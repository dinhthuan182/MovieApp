//
//  FilterMovieViewController.swift
//  MovieApplication
//
//  Created by Catalina on 2/5/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

class FilterMovieViewController: UIViewController {
    let window = UIApplication.shared.keyWindow
    let sortList = ["Most popular", "Best rated", "Release day", "Alphabetic order"]
    let cellId = "cellId"
    var releaseShowing = false
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView(frame: UIScreen.main.bounds)
        sv.isScrollEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let vTransparent: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let lblSorted: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sorted by"
        lbl.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btnSortList: UIButton = {
        let btn = UIButton()
        btn.isSelected = false
        btn.tag = 0
        btn.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addTranparentView), for: .touchUpInside)
        return btn
    }()
    
    let tbSort: UITableView = {
        let tb = UITableView()
        tb.layer.cornerRadius = 5
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    let vDatesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let lblDates: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dates"
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btnRelaseDesc: UIButton = {
        let btn = UIButton()
        btn.isSelected = false
        btn.tag = 1
        btn.setTitle("Release descending", for: .normal)
        btn.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addTranparentView), for: .touchUpInside)
        return btn
    }()
    
    let btnRelaseInStage: UIButton = {
        let btn = UIButton()
        btn.isSelected = false
        btn.tag = 2
        btn.setTitle("Release in stage", for: .normal)
        btn.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addTranparentView), for: .touchUpInside)
        return btn
    }()
    
    let vReleaseInStage: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()
    
    let txtFromDay: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let lblBetween: UILabel = {
        let lbl = UILabel()
        lbl.text = "-"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let txtToDay: UITextField = {
       let txt = UITextField()
       txt.translatesAutoresizingMaskIntoConstraints = false
       return txt
    }()
    
    let lblGenres: UILabel = {
        let lbl = UILabel()
        lbl.text = "Genres"
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Filter"
        view.backgroundColor = .white
        txtFromDay.inputView = datePicker
        txtToDay.inputView = datePicker
        setupView()
        tbSort.delegate = self
        tbSort.dataSource = self
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let frame = view.bounds
//        scrollView.frame = frame
//        scrollView.contentSize = CGSize(width: frame.width, height: frame.height + 10)
//    }

    
    @objc func addTranparentView(sender: UIButton) {
        let frames = sender.frame

        if sender.tag == 0 {
            
            vTransparent.frame = window?.frame ?? self.view.frame
            self.view.addSubview(vTransparent)
            tbSort.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            self.view.addSubview(tbSort)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            vTransparent.addGestureRecognizer(tapGesture)
            
            UIView.animate(withDuration: 0.4, delay: 0.0,usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.vTransparent.alpha = 0.5
                self.tbSort.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 200)
                self.vDatesContainer.frame = CGRect(x: 0, y: frames.origin.y + frames.height + self.tbSort.frame.height + 10, width: self.vDatesContainer.frame.width, height: self.vDatesContainer.frame.height)
                self.vReleaseInStage.frame = CGRect(x: self.vReleaseInStage.frame.origin.x, y: frames.origin.y + frames.height + self.tbSort.frame.height + 60, width: self.vReleaseInStage.frame.width, height: self.vReleaseInStage.frame.height)
            }, completion: nil)
        } else if sender.tag == 1 {
            sender.backgroundColor = .blue
            btnRelaseInStage.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
            hideDateTransparent()
        } else if sender.tag == 2 {
            sender.backgroundColor = .blue
            btnRelaseDesc.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
            
            if !releaseShowing {
                vReleaseInStage.frame = CGRect(x: frames.origin.x - frames.width, y: frames.origin.y + frames.height * 2 + 10, width: frames.width * 2, height: 0)
                self.view.addSubview(vReleaseInStage)

                setupDateTransparent()
            }
            releaseShowing = true
            UIView.animate(withDuration: 0.4, delay: 0.0,usingSpringWithDamping: 1.0,initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.vReleaseInStage.frame = CGRect(x: frames.origin.x - frames.width, y: frames.origin.y + frames.height * 2 + 10, width: frames.width * 2, height: 100)
                self.lblGenres.frame = CGRect(x: 0, y: frames.origin.y + frames.height + self.vReleaseInStage.frame.height + 10, width: self.lblGenres.frame.width, height: self.lblGenres.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func removeTransparentView() {
        let framesSort = btnSortList.frame
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.vTransparent.alpha = 0
            self.tbSort.frame = CGRect(x: framesSort.origin.x, y: framesSort.origin.y + framesSort.height, width: framesSort.width, height: 0)
            self.vDatesContainer.frame = CGRect(x: 0, y: framesSort.origin.y + framesSort.height + 10, width: self.vDatesContainer.frame.width, height: self.vDatesContainer.frame.height)
            self.vReleaseInStage.frame = CGRect(x: self.vReleaseInStage.frame.origin.x, y: framesSort.origin.y + framesSort.height + 60, width: self.vReleaseInStage.frame.width, height: self.vReleaseInStage.frame.height)
        }, completion: nil)
    }
    
    func hideDateTransparent() {
        let framesDate = btnRelaseInStage.frame

        releaseShowing = false
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.vReleaseInStage.frame = CGRect(x: framesDate.origin.x - framesDate.width, y: framesDate.origin.y + framesDate.height * 2 + 10, width: self.vReleaseInStage.frame.width, height: 0)
            self.lblGenres.frame = CGRect(x: 0, y: framesDate.origin.y + framesDate.height + 10, width: self.lblGenres.frame.width, height: self.lblGenres.frame.height)
        }, completion: nil)
    }
}

extension FilterMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = sortList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnSortList.setTitle(sortList[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
