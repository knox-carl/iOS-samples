//
//  ViewController.swift
//  DateCalcGUISwift
//
//  Created by Brian Moakley on 11/3/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
  
  
  var dateCalc: DateCalculator!
  @IBOutlet weak var resultsLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dateCalc = DateCalculator()
    dateCalc.hisName = "Ray"
    dateCalc.hisAge = 34
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func calcTapped(sender: AnyObject) {
    let shouldDate = dateCalc.shouldHeDateIfHerAgeIs(24)
    if shouldDate {
      resultsLabel.text = "He should date"
    } else {
      resultsLabel.text = "He should not date"
    }
  }

}

