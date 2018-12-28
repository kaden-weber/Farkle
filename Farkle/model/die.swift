//
//  die.swift
//  Farkle
//
//  Created by Kaden Weber on 12/21/18.
//  Copyright © 2018 Kaden Weber. All rights reserved.
//

import Foundation

class Die {
   
   var value = 1
   var state: DieState = DieState.disabled
   
   func roll(){
      if state == DieState.scoring || state == DieState.nonScoring {
         let newRoll = Int.random(in: 1...6)
         value = newRoll
      }
   }
   
   func set(newValue: Int){
      value = newValue
   }
   
}

enum DieState {
   //rolled dice, scoring, non scoring, scoring and selected, disabled
   case selected
   case scoring
   case nonScoring
   case disabled
}
