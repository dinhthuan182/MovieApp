//
//  PersonDetailViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/5/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: UIScreen.main.bounds)
        sv.isScrollEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
        
    }()
    
    let imgProfile: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lblPlaceOfBirth: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblBirthDay: UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customRGB(222, 222, 222, 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tvBiograpy: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var person: Person? {
        didSet {
            if let profilePath = person?.profilePath {
                let urlString = Api.general.getImageLink(profilePath)
                self.imgProfile.loadImageUsingCacheWithUrlString(urlString: urlString)
            }
            
            self.lblName.text = person?.name
            self.lblPlaceOfBirth.text = "Place of Birth: " + (person?.placeOfBirth)!
            self.lblBirthDay.text = "Brithday: " + (person?.birthday)!
            self.tvBiograpy.text = person?.biography
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let frame = view.bounds
        scrollView.frame = frame
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height + 10)
    }
    
    func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(imgProfile)
        scrollView.addSubview(vContent)
        
        vContent.addSubview(lblName)
        vContent.addSubview(lblPlaceOfBirth)
        vContent.addSubview(lblBirthDay)
        vContent.addSubview(separatorLine)
        vContent.addSubview(tvBiograpy)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imgProfile.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imgProfile.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            imgProfile.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imgProfile.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.6)
        ])

        NSLayoutConstraint.activate([
            vContent.topAnchor.constraint(equalTo: imgProfile.bottomAnchor, constant: 10),
            vContent.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            vContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            vContent.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: vContent.topAnchor, constant: 10),
            lblName.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            lblName.widthAnchor.constraint(equalTo: vContent.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lblPlaceOfBirth.topAnchor.constraint(equalTo: lblName.bottomAnchor),
            lblPlaceOfBirth.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            lblPlaceOfBirth.widthAnchor.constraint(equalTo: vContent.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lblBirthDay.topAnchor.constraint(equalTo: lblPlaceOfBirth.bottomAnchor),
            lblBirthDay.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            lblBirthDay.widthAnchor.constraint(equalTo: vContent.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: lblBirthDay.bottomAnchor, constant: 10),
            separatorLine.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            separatorLine.widthAnchor.constraint(equalTo: vContent.widthAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        let height = estimateFrameForText(text: tvBiograpy.text).height + 10
        NSLayoutConstraint.activate([
            tvBiograpy.topAnchor.constraint(equalTo: separatorLine.bottomAnchor),
            tvBiograpy.leftAnchor.constraint(equalTo: vContent.leftAnchor),
            tvBiograpy.widthAnchor.constraint(equalTo: vContent.widthAnchor),
            tvBiograpy.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let screenSize = UIScreen.main.bounds
        let size = CGSize(width: screenSize.width, height: screenSize.height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], context: nil)
    }
}
