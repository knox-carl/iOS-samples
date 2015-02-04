//
//  File.swift
//  DateCalcGUISwift
//
//  Created by Brian Moakley on 11/3/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import Foundation

class DateCalculator {
  
  var hisAge: Float = 0
  var hisName: String?
  
  init() {
    
  }
  
  func shouldHeDateIfHerAgeIs(herAge: Float) -> Bool {
    let minAgeToDate = hisAge / 2 + 7
    return herAge > minAgeToDate
  }
  
  
}
