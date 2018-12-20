//
//  ScoreKeeper.swift
//  Farkle
//
//  Created by Kaden Weber on 11/21/18.
//  Copyright © 2018 Kaden Weber. All rights reserved.
//

import Foundation

class ScoreKeeper {
   var currentPlayer = Player()
   var currentRoll = 0
   var currentScore = 0
   
   var players = [Player]()
   
   func addPlayer(name: String) {
      var newPlayer = Player()
      newPlayer.name = name
      players.append(newPlayer)
      
   }
   
   func addEndTurnScore() {
      currentPlayer.totalScore += currentScore
      currentScore = 0
      currentRoll = 0
   }
   
}

class Player {
   var name = ""
   var totalScore = 0
   
   
}
