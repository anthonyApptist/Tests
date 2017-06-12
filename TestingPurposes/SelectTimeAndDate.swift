//
//  SelectTimeAndDate.swift
//  TestingPurposes
//
//  Created by Anthony Ma on 2017-06-03.
//  Copyright © 2017 Anthony Ma. All rights reserved.
//

import Foundation
import UIKit

class SelectDateAndTime: UIViewController {
    
    enum SelectTime {
        case startTime
        case endTime
    }
    
    // view
    var selectingFor: SelectTime? = .startTime
    var dateTextfield: UITextField?
    var timePicker: UIDatePicker?
    
    // trainer
    var dateScheduled: String?
    
    // dates with appointments
    var trainerAppointments: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
        
        dateTextfield = UITextField()
        dateTextfield?.textAlignment = .center
        dateTextfield?.font = UIFont(name: "Avenir", size: 16)
        dateTextfield?.textColor = UIColor.black
        self.view.addSubview(dateTextfield!)
        dateTextfield?.translatesAutoresizingMaskIntoConstraints = false
        dateTextfield?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dateTextfield?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        dateTextfield?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        dateTextfield?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        
        timePicker = UIDatePicker()
        self.view.addSubview(timePicker!)
        timePicker?.addTarget(self, action: #selector(self.datePickerChanged(sender:)), for: .valueChanged)
        timePicker?.translatesAutoresizingMaskIntoConstraints = false
        timePicker?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        timePicker?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        timePicker?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        timePicker?.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.40).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        setViewFor(time: self.selectingFor!)
    }
    
    func setViewFor(time: SelectTime) {
        switch time {
        case .startTime:
            dateTextfield?.placeholder = "Pick a date"
            timePicker?.datePickerMode = .dateAndTime
            let next = UIButton(type: .system)
            next.setTitle(">", for: .normal)
            next.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
            self.view.addSubview(next)
            next.addTarget(self, action: #selector(endTimeSet), for: .touchUpInside)
            break
        case .endTime:
            dateTextfield?.placeholder = "Pick end time"
            timePicker?.datePickerMode = .time
            break
        }
    }
    
    func endTimeSet() {
        let selectEndTime = SelectDateAndTime()
        selectEndTime.selectingFor = .endTime
        selectEndTime.dateScheduled = dateTextfield?.text
        self.present(selectEndTime, animated: true, completion: nil)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        switch (self.selectingFor!) {
        case .startTime:
            formatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
            let dateString = formatter.string(from: sender.date)
            dateTextfield?.text = dateString
            break
        case .endTime:
            formatter.dateFormat = "h:mm a"
            let timeString = formatter.string(from: sender.date)
            let appointment = "\(self.dateScheduled!) to \(timeString)"
            dateTextfield?.text = appointment
            print(dateTextfield?.text!)
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dateTextfield?.resignFirstResponder()
    }
}
