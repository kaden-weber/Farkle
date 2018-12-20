//
//  Scorer.swift
//  Farkle
//
//  Created by Kaden Weber on 11/20/18.
//  Copyright © 2018 Kaden Weber. All rights reserved.
//

import Foundation

class Scorer {
   let ONES             = 100
   let FIVES            = 50
   let TRIPLE_ONES      = 1000
   let TRIPLE_TWOS      = 200
   let TRIPLE_THREES    = 300
   let TRIPLE_FOURS     = 400
   let TRIPLE_FIVES     = 500
   let TRIPLE_SIXES     = 600
   let DOUBLE_TRIPLES   = 2500
   let TRIPLE_DOUBLES   = 1500
   let STRAIGHT         = 3000   // 1 in 65 odds
   let SIX_OF_A_KIND    = 5000   // maybe set equal to max value for the game (1 in 7776 odds)
   //ADD MORE ALTERNATE SCORES LATER
   
   var values = [Int]()
   
   //possibly implement here later
   //func getScoringDice
   
   func getScoreForRoll(dice: DiceSet) -> Int {
      self.values = dice.rolledValues()
      var score = 0
      if values.count > 2 {
         score = checkForCombos()
         // all of these combos require all six die
         if score == DOUBLE_TRIPLES || score == TRIPLE_DOUBLES || score == STRAIGHT || score == SIX_OF_A_KIND {
            return score
         }
      }
      //check for singles (triples have been removed from consideration)
      for value in self.values {
         if value == 1 {
            score += ONES
         } else if value == 5 {
            score += FIVES
         }
      }
      return score
   }
   
   func checkForCombos() -> Int {
      var counts = [0, 0, 0, 0, 0, 0]
      for value in self.values {
         counts[value-1] += 1
      }
      var score = 0
      
      // only possible with all 6 dice
      if self.values.count == 6 {
         //check for triple doubles
         score = tripleDoubleCheck(counts: counts)
         if score == TRIPLE_DOUBLES {
            return score
         }
         //check for a straight
         score = straightCheck(counts: counts)
         if score == STRAIGHT {
            return score
         }
         // check for six of a kind
         score = sixOfAKindCheck(counts: counts)
         if score == SIX_OF_A_KIND {
            return score
         }
      }
      //check for any triples
      var numberOfTriples = 0
      if counts[0] >= 3 {
         score += TRIPLE_ONES
         removeTriplesFromValues(valueToRemove: 1)
         numberOfTriples += 1
      }
      if counts[1] >= 3 {
         score += TRIPLE_TWOS
         removeTriplesFromValues(valueToRemove: 2)
         numberOfTriples += 1
      }
      if counts[2] >= 3 {
         score += TRIPLE_THREES
         removeTriplesFromValues(valueToRemove: 3)
         numberOfTriples += 1
      }
      if counts[3] >= 3 {
         score += TRIPLE_FOURS
         removeTriplesFromValues(valueToRemove: 4)
         numberOfTriples += 1
      }
      if counts[4] >= 3 {
         score += TRIPLE_FIVES
         removeTriplesFromValues(valueToRemove: 5)
         numberOfTriples += 1
      }
      if counts[5] >= 3 {
         score += TRIPLE_SIXES
         removeTriplesFromValues(valueToRemove: 6)
         numberOfTriples += 1
      }
      //check for double triples
      if numberOfTriples > 1 {
         score = DOUBLE_TRIPLES
      }
      return score
   }
   
   func removeTriplesFromValues(valueToRemove: Int) {
      var count = 3
      while count > 0 {
         self.values.remove(at: self.values.firstIndex(of: valueToRemove)!)
         
         count -= 1
      }
   }
   
   func tripleDoubleCheck(counts: [Int]) -> Int {
      var numberOfDoubles = 0
      if counts[0] == 2 {
         numberOfDoubles += 1
      }
      if counts[1] == 2 {
         numberOfDoubles += 1
      }
      if counts[2] == 2 {
         numberOfDoubles += 1
      }
      if counts[3] == 2 {
         numberOfDoubles += 1
      }
      if counts[4] == 2 {
         numberOfDoubles += 1
      }
      if counts[5] == 2 {
         numberOfDoubles += 1
      }
      if numberOfDoubles == 3 {
         return TRIPLE_DOUBLES
      }
      return 0
   }
   func straightCheck(counts: [Int]) -> Int {
      var isStraight = true
      if counts[0] != 1 {
         isStraight = false
      }
      if counts[1] != 1 {
         isStraight = false
      }
      if counts[2] != 1 {
         isStraight = false
      }
      if counts[3] != 1 {
         isStraight = false
      }
      if counts[4] != 1 {
         isStraight = false
      }
      if counts[5] != 1 {
         isStraight = false
      }
      
      if isStraight {
         return STRAIGHT
      } else {
         return 0
      }
   }
   func sixOfAKindCheck(counts: [Int]) -> Int {
      var sixOfAKindFound = false
      for count in counts {
         if count == 6 {
            sixOfAKindFound = true
         }
      }
      if sixOfAKindFound {
         return SIX_OF_A_KIND
      }
      return 0
   }
   
}
