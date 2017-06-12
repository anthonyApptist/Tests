//
//  ListAppointmentVC.swift
//  TestingPurposes
//
//  Created by Anthony Ma on 2017-06-06.
//  Copyright © 2017 Anthony Ma. All rights reserved.
//

import Foundation
import UIKit


struct Appointment {
    
    let location: String
    let date: String
    let time: String
    
}

class ListAppointmentVC: UIViewController, UIScrollViewDelegate {
    
    let detailView = UIView()
    
    var closeBtn: UIButton!
    
    var blurEffect: UIBlurEffect!
    var blurEffectView: UIVisualEffectView!
    
    var apptTitleLbl: UILabel!
//    var descriptionLbl: UILabel!
    
    var apptScrollView: UIScrollView!
    
    // appointments
    var appointments: [Appointment] = []
    var pages: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // blur background
        blurEffectView.backgroundColor = UIColor.darkGray
        blurEffectView.alpha = 0.8
        self.view.addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        blurEffectView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        blurEffectView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        blurEffectView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // dismiss button
        closeBtn = UIButton(type: .system)
        closeBtn.addTarget(self, action: #selector(closedBtnPressed), for: .touchUpInside)
        //        closeBtn.setImage(#imageLiteral(resourceName: "cancel_button.png"), for: .normal)
        closeBtn.setTitle("X", for: .normal)
        self.view.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        closeBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // title labels
        apptTitleLbl = UILabel()
        apptTitleLbl.text = "Appointment"
        apptTitleLbl.textAlignment = .center
        apptTitleLbl.textColor = UIColor.white
        apptTitleLbl.font = UIFont(name: "SFUIText-Medium", size: 33)
        self.view.addSubview(apptTitleLbl)
        apptTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        apptTitleLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        apptTitleLbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        apptTitleLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        apptTitleLbl.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        apptScrollView = UIScrollView()
        apptScrollView.alwaysBounceHorizontal = false
        apptScrollView.isPagingEnabled = true
        apptScrollView.showsHorizontalScrollIndicator = true
        apptScrollView.delegate = self
        pages = self.numberOfAppointments()
        self.view.addSubview(apptScrollView)
        apptScrollView.translatesAutoresizingMaskIntoConstraints = false
        apptScrollView.topAnchor.constraint(equalTo: apptTitleLbl.bottomAnchor, constant: 50).isActive = true
        apptScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        apptScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: pages!).isActive = true
        apptScrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    // Scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setUpScrollViewNextPage()
    }
    
    // Scroll view datasource
    func numberOfAppointments() -> CGFloat {
        return CGFloat(appointments.count)
    }
    
    func setUpScrollViewNextPage() {
        let width = self.apptScrollView.frame.width/pages!
        
    }
    
    /*
    func makeDetailView() -> UIView {
        detailView.backgroundColor = UIColor.clear
        
        
        self.view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        detailView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        detailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        detailView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        let titleLbl = UILabel()
        detailView.addSubview(titleLbl)
        titleLbl.text = "Appointment Details"
        titleLbl.textColor = UIColor.white
        titleLbl.textAlignment = .center
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.font = UIFont(name: "SFUIText-Medium", size: 33)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        titleLbl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        
        let subTitleLbl = UILabel()
        detailView.addSubview(subTitleLbl)
        subTitleLbl.text = "View and edit your appointments"
        subTitleLbl.textColor = UIColor.white
        subTitleLbl.textAlignment = .center
        subTitleLbl.adjustsFontSizeToFitWidth = true
        subTitleLbl.font = UIFont(name: "SFUIText-Light", size: 20)
        subTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        subTitleLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 0).isActive = true
        subTitleLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        subTitleLbl.widthAnchor.constraint(equalTo: titleLbl.widthAnchor, multiplier: 0.9).isActive = true
        subTitleLbl.heightAnchor.constraint(equalTo: titleLbl.heightAnchor, multiplier: 0.4).isActive = true
        
        let statusView = UIView()
        detailView.addSubview(statusView)
        statusView.backgroundColor = UIColor.lightGray
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        statusView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        statusView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        statusView.topAnchor.constraint(equalTo: subTitleLbl.bottomAnchor, constant: 50).isActive = true
        
        let statusLbl = UILabel()
        detailView.addSubview(statusLbl)
        statusLbl.text = "Status"
        statusLbl.textAlignment = .center
        statusLbl.textColor = UIColor.white
        statusLbl.font = UIFont(name: "SFUIText-Light", size: 22)
        statusLbl.translatesAutoresizingMaskIntoConstraints = false
        statusLbl.widthAnchor.constraint(equalTo: statusView.widthAnchor, multiplier: 0.2).isActive = true
        statusLbl.heightAnchor.constraint(equalTo: statusView.heightAnchor, multiplier: 0.8).isActive = true
        statusLbl.centerXAnchor.constraint(equalTo: statusView.centerXAnchor).isActive = true
        statusLbl.centerYAnchor.constraint(equalTo: statusView.centerYAnchor).isActive = true
        
        let confirmedLbl = UILabel()
        detailView.addSubview(confirmedLbl)
        confirmedLbl.text = "Confirmed"
        confirmedLbl.textAlignment = .center
        confirmedLbl.textColor = UIColor.white
        confirmedLbl.font = UIFont(name: "SFUIText-Light", size: 16)
        confirmedLbl.translatesAutoresizingMaskIntoConstraints = false
        confirmedLbl.widthAnchor.constraint(equalTo: statusView.widthAnchor, multiplier: 0.7).isActive = true
        confirmedLbl.heightAnchor.constraint(equalTo: statusView.heightAnchor, multiplier: 0.5).isActive = true
        confirmedLbl.centerXAnchor.constraint(equalTo: statusView.centerXAnchor).isActive = true
        confirmedLbl.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 10).isActive = true
        
        let trainerView = UIView()
        detailView.addSubview(trainerView)
        trainerView.backgroundColor = UIColor.lightGray
        trainerView.translatesAutoresizingMaskIntoConstraints = false
        trainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        trainerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        trainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        trainerView.topAnchor.constraint(equalTo: confirmedLbl.bottomAnchor, constant: 10).isActive = true
        
        let trainerLbl = UILabel()
        trainerLbl.text = "Trainer"
        trainerLbl.textAlignment = .center
        trainerLbl.font = UIFont(name: "SFUIText-Light", size: 22)
        trainerLbl.textColor = UIColor.white
        detailView.addSubview(trainerLbl)
        trainerLbl.translatesAutoresizingMaskIntoConstraints = false
        trainerLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        trainerLbl.heightAnchor.constraint(equalTo: trainerView.heightAnchor, multiplier: 1.0).isActive = true
        trainerLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        trainerLbl.centerYAnchor.constraint(equalTo: trainerView.centerYAnchor).isActive = true
        
        let locationLbl = UILabel()
        locationLbl.text = "Location"
        locationLbl.textAlignment = .center
        locationLbl.font = UIFont(name: "SFUIText-Light", size: 22)
        locationLbl.textColor = UIColor.white
        detailView.addSubview(locationLbl)
        locationLbl.translatesAutoresizingMaskIntoConstraints = false
        locationLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        locationLbl.heightAnchor.constraint(equalTo: trainerView.heightAnchor, multiplier: 1.0).isActive = true
        locationLbl.leadingAnchor.constraint(equalTo: trainerLbl.trailingAnchor, constant: 30).isActive = true
        locationLbl.centerYAnchor.constraint(equalTo: trainerView.centerYAnchor).isActive = true
        
        let locationEditBtn = UIButton()
        detailView.addSubview(locationEditBtn)
        locationEditBtn.setImage(#imageLiteral(resourceName: "text_edit_ic.png"), for: .normal)
        locationEditBtn.translatesAutoresizingMaskIntoConstraints = false
        locationEditBtn.leadingAnchor.constraint(equalTo: locationLbl.trailingAnchor, constant: -10).isActive = true
        locationEditBtn.centerYAnchor.constraint(equalTo: locationLbl.centerYAnchor).isActive = true
        locationEditBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locationEditBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let imageView = UIImageView()
        self.detailView.addSubview(imageView)
        imageView.makeRound()
        imageView.image = #imageLiteral(resourceName: "sample_image.png")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        imageView.topAnchor.constraint(equalTo: trainerView.bottomAnchor, constant: 10).isActive = true
        
        
        let nameLbl = UILabel()
        self.detailView.addSubview(nameLbl)
        nameLbl.text = "John Smith"
        nameLbl.font = UIFont(name: "SFUIText-Light", size: 14)
        nameLbl.textAlignment = .left
        nameLbl.textColor = UIColor.white
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        nameLbl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.02).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15).isActive = true
        nameLbl.topAnchor.constraint(equalTo: trainerView.bottomAnchor, constant: 20).isActive = true
        
        let addressLbl = UILabel()
        detailView.addSubview(addressLbl)
        addressLbl.textColor = UIColor.white
        addressLbl.font = UIFont(name: "SFUIText-Light", size: 14)
        addressLbl.text = "285 Cordial Dr,"
        addressLbl.adjustsFontSizeToFitWidth = true
        addressLbl.textAlignment = .center
        addressLbl.numberOfLines = 2
        addressLbl.translatesAutoresizingMaskIntoConstraints = false
        addressLbl.widthAnchor.constraint(equalTo: detailView.widthAnchor, multiplier: 0.4).isActive = true
        addressLbl.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        addressLbl.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -15).isActive = true
        addressLbl.topAnchor.constraint(equalTo: nameLbl.topAnchor, constant: 0).isActive = true
        
        let addressLbl2 = UILabel()
        detailView.addSubview(addressLbl2)
        addressLbl2.textColor = UIColor.white
        addressLbl2.font = UIFont(name: "SFUIText-Light", size: 14)
        addressLbl2.text = "Bridgeville, PA, 15017"
        addressLbl2.adjustsFontSizeToFitWidth = true
        addressLbl2.textAlignment = .center
        addressLbl2.numberOfLines = 2
        addressLbl2.translatesAutoresizingMaskIntoConstraints = false
        addressLbl2.widthAnchor.constraint(equalTo: detailView.widthAnchor, multiplier: 0.4).isActive = true
        addressLbl2.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        addressLbl2.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -15).isActive = true
        addressLbl2.topAnchor.constraint(equalTo: addressLbl.bottomAnchor, constant: 0).isActive = true
        
        
        let dateTimeView = UIView()
        detailView.addSubview(dateTimeView)
        dateTimeView.backgroundColor = UIColor.lightGray
        dateTimeView.translatesAutoresizingMaskIntoConstraints = false
        dateTimeView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        dateTimeView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        dateTimeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dateTimeView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        
        let dateLbl = UILabel()
        dateLbl.font = UIFont(name: "SFUIText-Light", size: 22)
        dateLbl.textAlignment = .center
        dateLbl.text = "Date"
        dateLbl.textColor = UIColor.white
        detailView.addSubview(dateLbl)
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.centerXAnchor.constraint(equalTo: trainerLbl.centerXAnchor, constant: 0).isActive = true
        dateLbl.widthAnchor.constraint(equalTo: self.detailView.widthAnchor, multiplier: 0.2).isActive = true
        dateLbl.topAnchor.constraint(equalTo: dateTimeView.topAnchor, constant: 0).isActive = true
        dateLbl.heightAnchor.constraint(equalTo: dateTimeView.heightAnchor, constant: 0).isActive = true
        
        let dateLblEditBtn = UIButton()
        detailView.addSubview(dateLblEditBtn)
        dateLblEditBtn.setImage(#imageLiteral(resourceName: "text_edit_ic.png"), for: .normal)
        dateLblEditBtn.translatesAutoresizingMaskIntoConstraints = false
        dateLblEditBtn.leadingAnchor.constraint(equalTo: dateLbl.trailingAnchor, constant: -10).isActive = true
        dateLblEditBtn.centerYAnchor.constraint(equalTo: dateLbl.centerYAnchor).isActive = true
        dateLblEditBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dateLblEditBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let dateDetailLbl = UILabel()
        detailView.addSubview(dateDetailLbl)
        dateDetailLbl.translatesAutoresizingMaskIntoConstraints = false
        dateDetailLbl.text = "Sept. 6, 2016"
        dateDetailLbl.textAlignment = .center
        dateDetailLbl.textColor = UIColor.white
        dateDetailLbl.font = UIFont(name: "SFUIText-Light", size: 14)
        dateDetailLbl.topAnchor.constraint(equalTo: dateTimeView.bottomAnchor, constant: 0).isActive = true
        dateDetailLbl.widthAnchor.constraint(equalTo: detailView.widthAnchor, multiplier: 0.5).isActive = true
        dateDetailLbl.heightAnchor.constraint(equalTo: detailView.heightAnchor, multiplier: 0.1).isActive = true
        dateDetailLbl.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 0).isActive = true
        
        let timeDetailLbl = UILabel()
        detailView.addSubview(timeDetailLbl)
        timeDetailLbl.translatesAutoresizingMaskIntoConstraints = false
        timeDetailLbl.text = "8:00 am"
        timeDetailLbl.textColor = UIColor.white
        timeDetailLbl.textAlignment = .center
        timeDetailLbl.font = UIFont(name: "SFUIText-Light", size: 14)
        timeDetailLbl.topAnchor.constraint(equalTo: dateTimeView.bottomAnchor, constant: 0).isActive = true
        timeDetailLbl.widthAnchor.constraint(equalTo: detailView.widthAnchor, multiplier: 0.5).isActive = true
        timeDetailLbl.heightAnchor.constraint(equalTo: detailView.heightAnchor, multiplier: 0.1).isActive = true
        timeDetailLbl.leadingAnchor.constraint(equalTo: dateDetailLbl.trailingAnchor, constant: 0).isActive = true
        
        let timeLbl = UILabel()
        timeLbl.font = UIFont(name: "SFUIText-Light", size: 22)
        timeLbl.textAlignment = .center
        timeLbl.text = "Time"
        timeLbl.textColor = UIColor.white
        detailView.addSubview(timeLbl)
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        timeLbl.centerXAnchor.constraint(equalTo: locationLbl.centerXAnchor, constant: 0).isActive = true
        timeLbl.widthAnchor.constraint(equalTo: self.detailView.widthAnchor, multiplier: 0.2).isActive = true
        timeLbl.topAnchor.constraint(equalTo: dateTimeView.topAnchor, constant: 0).isActive = true
        timeLbl.heightAnchor.constraint(equalTo: dateTimeView.heightAnchor, constant: 0).isActive = true
        
        let timeLblEditBtn = UIButton()
        detailView.addSubview(timeLblEditBtn)
        timeLblEditBtn.setImage(#imageLiteral(resourceName: "text_edit_ic.png"), for: .normal)
        timeLblEditBtn.translatesAutoresizingMaskIntoConstraints = false
        timeLblEditBtn.leadingAnchor.constraint(equalTo: timeLbl.trailingAnchor, constant: -10).isActive = true
        timeLblEditBtn.centerYAnchor.constraint(equalTo: timeLbl.centerYAnchor).isActive = true
        timeLblEditBtn.widthAnchor.constraint(equalToConstant: 20).isActive = true
        timeLblEditBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return detailView
    }
    */
    
    func closedBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func makeRound() {
        let radius = self.frame.width/2
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
