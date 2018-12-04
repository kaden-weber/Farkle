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
   fileprivate var myDiceSet: [Dice] = []
   
   init() {
      for index in 1...6 {
         let newDice = Dice.init()
         newDice.set(newValue: index)
         myDiceSet.append(newDice)
      }
   }
   
   func getImageForDice(position: Int) -> UIImage? {
      return myDiceSet[position-1].image
   }
   
   func diceIsSelected(position: Int) -> Bool {
      return myDiceSet[position-1].selected
   }
   
   func roll() {
      for dice in myDiceSet {
         if !dice.selected {
            dice.roll()
         }
      }
   }
   
}

class Dice {
   
   var value = 1
   var image = UIImage(named: "dice-one")
   var selected = false
   
   func roll(){
      let newRoll = Int.random(in: 1...6)
      set(newValue: newRoll)
   }
   
   func set(newValue: Int){
      value = newValue
      if newValue == 1 {
         image = UIImage(named: "dice-one")
      } else if newValue == 2 {
         image = UIImage(named: "dice-two")
      } else if newValue == 3 {
         image = UIImage(named: "dice-three")
      } else if newValue == 4 {
         image = UIImage(named: "dice-four")
      } else if newValue == 5 {
         image = UIImage(named: "dice-five")
      } else if newValue == 6 {
         image = UIImage(named: "dice-six")
      }
   }
   
}


