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
   
   func getImageForDie(position: Int) -> UIImage? {
      return dieAt(position: position).image
   }
   
   func dieIsSelected(position: Int) -> Bool {
      return dieAt(position: position).selected
   }
   
   func dieIsSelectable(position: Int) -> Bool {
      return dieAt(position: position).selectable
   }
   
   func setDie(selected: Bool, position: Int) {
      dieAt(position: position).selected = selected
   }
   
   func setDie(selectable: Bool, position: Int) {
      dieAt(position: position).selectable = selectable
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
         if !die.selected {
            die.roll()
         }
      }
   }
   
   func rolledValues() -> [Int] {
      var values = [Int]()
      for die in myDiceSet {
         if !die.selected {
            values.append(die.value)
         }
      }
      return values
   }
   
}

class Die {
   
   var value = 1
   var image = UIImage(named: "dice-one")
   var selectable = false
   var selected = false
   
   func roll(){
      let newRoll = Int.random(in: 1...6)
      value = newRoll
      set(newValue: newRoll)
   }
   
   func set(newValue: Int){
      value = newValue
   }
   
}


