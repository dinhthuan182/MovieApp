//
//  FilterMovieViewController+UI.swift
//  MovieApplication
//
//  Created by Catalina on 2/6/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

extension FilterMovieViewController {
    
    func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(lblSorted)
        scrollView.addSubview(btnSortList)
        
        scrollView.addSubview(vDatesContainer)
        vDatesContainer.addSubview(lblDates)
        vDatesContainer.addSubview(btnRelaseDesc)
        vDatesContainer.addSubview(btnRelaseInStage)
        vDatesContainer.addSubview(vReleaseInStage)
        
        vDatesContainer.addSubview(lblGenres)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
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
            lblGenres.topAnchor.constraint(equalTo: btnRelaseInStage.bottomAnchor, constant: 10),
            lblGenres.leftAnchor.constraint(equalTo: vDatesContainer.leftAnchor),
            lblGenres.widthAnchor.constraint(equalTo: vDatesContainer.widthAnchor)
        ])
    }
    
    func setupDateTransparent() {
        txtFromDay.backgroundColor = .yellow
        print(vReleaseInStage.frame)
        txtFromDay.frame = CGRect(x: self.btnRelaseDesc.frame.origin.x + 100, y: self.btnRelaseDesc.frame.origin.y + 100, width: self.btnRelaseDesc.frame.width, height: 50)
        print(txtFromDay.frame)
        self.view.addSubview(txtFromDay)
        self.view.addSubview(lblBetween)
        self.view.addSubview(txtToDay)
    }
}
