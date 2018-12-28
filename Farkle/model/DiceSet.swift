//
//  DiceSet.swift
//  Farkle
//
//  Created by Kaden Weber on 11/18/18.
//  Copyright © 2018 Kaden Weber. All rights reserved.
//

import Foundation
import UIKit

class DiceSet {
   fileprivate var myDiceSet: [Die] = []
   
   init() {
      for index in 1...6 {
         let newDie = Die.init()
         newDie.set(newValue: index)
         myDiceSet.append(newDie)
      }
   }
   
   func dieIsSelected(position: Int) -> Bool {
      if dieAt(position: position).state == DieState.selected {
         return true
      } else {
         return false
      }
   }
   
   func dieIsSelectable(position: Int) -> Bool {
      if dieAt(position: position).state == DieState.scoring {
         return true
      } else {
         return false
      }   }
   
   func setDie(selected: Bool, position: Int) {
      dieAt(position: position).state = DieState.selected
   }
   
   func setDie(selectable: Bool, position: Int) {
      dieAt(position: position).state = DieState.scoring
   }
   
   func setDie(state: DieState, position: Int) {
      dieAt(position: position).state = state
   }
   
   func valueAt(position: Int) -> Int {
      return dieAt(position: position).value
   }
   
   //??
   func atLeastOneScoringSetOfDiceIsSelected() -> Bool {
      return false
   }
   
   func valueIsInATriple(value: Int) -> Bool {
      var count = 0
      for die in myDiceSet {
         if die.value == value {
            count += 1
         }
      }
      if count > 3 {
         return true
      }
      return false
   }
   
   fileprivate func dieAt(position: Int) -> Die {
      return myDiceSet[position-1]
   }
   
   func roll() {
      for die in myDiceSet {
         die.roll()
      }
   }
   
   func rolledValues() -> [Int] {
      var values = [Int]()
      for die in myDiceSet {
         if die.state != DieState.selected || die.state != DieState.disabled {
            values.append(die.value)
         }
      }
      return values
   }
   
}



