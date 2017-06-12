//
//  ViewController.swift
//  TestingPurposes
//
//  Created by Anthony Ma on 2/6/2017.
//  Copyright © 2017 Anthony Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dates = ["11:00 PM on June 06, 2017 to 12:00 PM", "11:00 PM on June 07, 2017 to 12:00 PM"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brown
        
        let date1 = dates[0]
        let date2 = dates[1]
        
        
    }

    func filterDate(date: String) {
        
        let students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
        if let i = students.index(where: { $0.hasPrefix("A") }) {
            print("\(students[i]) starts with 'A'!")
        }
        
    }

}

