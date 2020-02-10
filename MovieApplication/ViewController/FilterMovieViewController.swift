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
    let genresList = ["Action & adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family", "Kids", "Mystery", "News", "Reality", "Talk", "Soap", "War & Politics", "Western"]
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
        view.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var fromDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.addTarget(self, action: #selector(fromDateChange), for: .valueChanged)
        return dp
    }()
    
    private var toDatePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.addTarget(self, action: #selector(toDateChange), for: .valueChanged)
        return dp
    }()
    
    var pickerToolbar: UIToolbar = {
        let tb = UIToolbar()
        tb.autoresizingMask = .flexibleHeight
        
        //customize the toolbar
        tb.barStyle = .default
        tb.barTintColor = UIColor.customRGB(200, 200, 200, 0.8)
        tb.backgroundColor = UIColor.white
        tb.isTranslucent = false
        
        //add buttons
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
            #selector(doneBtnClicked))
        doneButton.tintColor = UIColor.white
        
        //add the items to the toolbar
        tb.items = [flexSpace, doneButton]
        return tb
    }()
    
    let txtFromDay: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Start day"
        txt.textAlignment = .center
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let lblBetween: UILabel = {
        let lbl = UILabel()
        lbl.text = "-"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let txtToDay: UITextField = {
        let txt = UITextField()
        txt.placeholder = "End day"
        txt.textAlignment = .center
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
    
    let clvGenres: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let clv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clv.register(GenresCell.self, forCellWithReuseIdentifier: "genresCellId")
        clv.backgroundColor = .white
        clv.translatesAutoresizingMaskIntoConstraints = false
        return clv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Filter"
        view.backgroundColor = .white
        
        txtFromDay.inputAccessoryView = pickerToolbar
        txtToDay.inputAccessoryView = pickerToolbar
        txtFromDay.inputView = fromDatePicker
        txtToDay.inputView = toDatePicker
        setupView()
        tbSort.delegate = self
        tbSort.dataSource = self
        
        clvGenres.delegate = self
        clvGenres.dataSource = self
    }
    
    @objc func addTranparentView(sender: UIButton) {
        if sender.tag == 0 {
            let frames = sender.frame
            vTransparent.frame = window?.frame ?? self.view.frame
            self.view.addSubview(vTransparent)
            tbSort.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            self.view.addSubview(tbSort)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            vTransparent.addGestureRecognizer(tapGesture)
            
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.vTransparent.alpha = 0.5
                self.tbSort.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 200)
                self.vDatesContainer.frame = CGRect(x: 0, y: frames.origin.y + frames.height + self.tbSort.frame.height + 10, width: self.vDatesContainer.frame.width, height: self.vDatesContainer.frame.height)
            }, completion: nil)
        } else if sender.tag == 1 {
            sender.backgroundColor = .blue
            vReleaseInStage.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
            btnRelaseInStage.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
        } else if sender.tag == 2 {
            sender.backgroundColor = .blue
            vReleaseInStage.backgroundColor = .blue
            btnRelaseDesc.backgroundColor = UIColor.customRGB(200, 200, 200, 1)
        }
    }
    
    @objc func removeTransparentView() {
        let framesSort = btnSortList.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.vTransparent.alpha = 0
            self.tbSort.frame = CGRect(x: framesSort.origin.x, y: framesSort.origin.y + framesSort.height, width: framesSort.width, height: 0)
            self.vDatesContainer.frame = CGRect(x: 0, y: framesSort.origin.y + framesSort.height + 10, width: self.vDatesContainer.frame.width, height: self.vDatesContainer.frame.height)
        }, completion: nil)
    }
    
    @objc func fromDateChange(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtFromDay.text = dateFormatter.string(from: picker.date)
        toDatePicker.minimumDate = picker.date
    }
    
    @objc func toDateChange(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        txtToDay.text = dateFormatter.string(from: picker.date)
    }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        txtFromDay.resignFirstResponder()
        txtToDay.resignFirstResponder()
    }
    
    func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(lblSorted)
        scrollView.addSubview(btnSortList)
        
        scrollView.addSubview(vDatesContainer)
        vDatesContainer.addSubview(lblDates)
        vDatesContainer.addSubview(btnRelaseDesc)
        vDatesContainer.addSubview(btnRelaseInStage)
        vDatesContainer.addSubview(vReleaseInStage)
        
        vReleaseInStage.addSubview(txtFromDay)
        vReleaseInStage.addSubview(lblBetween)
        vReleaseInStage.addSubview(txtToDay)
        
        vDatesContainer.addSubview(lblGenres)
        vDatesContainer.addSubview(clvGenres)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -10),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lblSorted.topAnchor.constraint(equalTo: scrollView.topAnchor),
            lblSorted.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            lblSorted.widthAnchor.constraint(equalToConstant: 100),
            lblSorted.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            btnSortList.topAnchor.constraint(equalTo: scrollView.topAnchor),
            btnSortList.leftAnchor.constraint(equalTo: lblSorted.rightAnchor),
            btnSortList.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -100),
            btnSortList.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            vDatesContainer.topAnchor.constraint(equalTo: lblSorted.bottomAnchor, constant: 10),
            vDatesContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            vDatesContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            vDatesContainer.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            lblDates.topAnchor.constraint(equalTo: vDatesContainer.topAnchor),
            lblDates.leftAnchor.constraint(equalTo: vDatesContainer.leftAnchor),
            lblDates.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.2),
            lblDates.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            btnRelaseDesc.topAnchor.constraint(equalTo: lblDates.topAnchor),
            btnRelaseDesc.leftAnchor.constraint(equalTo: lblDates.rightAnchor),
            btnRelaseDesc.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.4),
            btnRelaseDesc.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            btnRelaseInStage.topAnchor.constraint(equalTo: lblDates.topAnchor),
            btnRelaseInStage.leftAnchor.constraint(equalTo: btnRelaseDesc.rightAnchor),
            btnRelaseInStage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.4),
            btnRelaseInStage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            vReleaseInStage.topAnchor.constraint(equalTo: btnRelaseDesc.bottomAnchor),
            vReleaseInStage.leftAnchor.constraint(equalTo: btnRelaseDesc.leftAnchor),
            vReleaseInStage.widthAnchor.constraint(equalTo: btnRelaseDesc.widthAnchor, multiplier: 2),
            vReleaseInStage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            txtFromDay.topAnchor.constraint(equalTo: vReleaseInStage.topAnchor),
            txtFromDay.leftAnchor.constraint(equalTo: vReleaseInStage.leftAnchor),
            txtFromDay.widthAnchor.constraint(equalTo: vReleaseInStage.widthAnchor, multiplier: 0.48),
            txtFromDay.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            lblBetween.topAnchor.constraint(equalTo: vReleaseInStage.topAnchor),
            lblBetween.leftAnchor.constraint(equalTo: txtFromDay.rightAnchor),
            lblBetween.widthAnchor.constraint(equalTo: vReleaseInStage.widthAnchor, multiplier: 0.04),
            lblBetween.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            txtToDay.topAnchor.constraint(equalTo: vReleaseInStage.topAnchor),
            txtToDay.leftAnchor.constraint(equalTo: lblBetween.rightAnchor),
            txtToDay.widthAnchor.constraint(equalTo: vReleaseInStage.widthAnchor, multiplier: 0.48),
            txtToDay.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            lblGenres.topAnchor.constraint(equalTo: vReleaseInStage.bottomAnchor, constant: 10),
            lblGenres.leftAnchor.constraint(equalTo: vDatesContainer.leftAnchor),
            lblGenres.widthAnchor.constraint(equalTo: vDatesContainer.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            clvGenres.topAnchor.constraint(equalTo: lblGenres.topAnchor),
            clvGenres.leftAnchor.constraint(equalTo: lblGenres.rightAnchor),
            clvGenres.widthAnchor.constraint(equalTo: vDatesContainer.widthAnchor, multiplier: 0.8),
            clvGenres.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
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

extension FilterMovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genresCellId", for: indexPath) as! GenresCell
        cell.backgroundColor = .cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: 30)
    }
}
