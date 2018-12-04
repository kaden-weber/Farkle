//
//  DiceViewController.swift
//  Farkle
//
//  Created by Kaden Weber on 11/18/18.
//  Copyright © 2018 Kaden Weber. All rights reserved.
//

import UIKit

class DiceViewController: UIViewController {

   //Mark: Outlets and actions
   @IBOutlet weak var diceOneButton: UIButton!
   @IBAction func diceOneButtonPressed(_ sender: Any) {
      toggleSelected(position: 1)
   }
   @IBOutlet weak var diceTwoButton: UIButton!
   @IBAction func diceTwoButtonPressed(_ sender: Any) {
      toggleSelected(position: 2)
   }
   @IBOutlet weak var diceThreeButton: UIButton!
   @IBAction func diceThreeButtonPressed(_ sender: Any) {
      toggleSelected(position: 3)
   }
   @IBOutlet weak var diceFourButton: UIButton!
   @IBAction func diceFourButtonPressed(_ sender: Any) {
      toggleSelected(position: 4)
   }
   @IBOutlet weak var diceFiveButton: UIButton!
   @IBAction func diceFiveButtonPressed(_ sender: Any) {
      toggleSelected(position: 5)
   }
   @IBOutlet weak var diceSixButton: UIButton!
   @IBAction func diceSixButtonPressed(_ sender: Any) {
      toggleSelected(position: 6)
   }
   
   @IBOutlet weak var rollButton: UIButton!
   @IBAction func rollButtonPressed(_ sender: Any) {
      diceSet.roll()
      setDiceImages()
      getScore()
   }
   @IBAction func endTurnButtonPressed(_ sender: Any) {
      diceSet = DiceSet()
      scoreKeeper.addEndTurnScore()
      setDiceImages()
      
      totalScoreField.text = String(scoreKeeper.currentScore)
      scoreFromRollField.text = String(scoreKeeper.currentRoll)
   }
   
   @IBOutlet weak var totalScoreField: UILabel!
   @IBOutlet weak var scoreFromRollField: UILabel!
   
   
   // Mark: Member variables
   var diceSet = DiceSet()
   var diceButtonList: [UIButton] = []
   let scorer = Scorer()
   let scoreKeeper = ScoreKeeper()
   
   // Mark: Functions
   override func viewDidLoad() {
      super.viewDidLoad()

      rollButton.setTitle("Roll", for: UIControl.State.normal)
      
      diceButtonList.append(diceOneButton)
      diceButtonList.append(diceTwoButton)
      diceButtonList.append(diceThreeButton)
      diceButtonList.append(diceFourButton)
      diceButtonList.append(diceFiveButton)
      diceButtonList.append(diceSixButton)

      setDiceImages()
   }
   
   func toggleSelected(position: Int) {
      if diceSet.dieIsSelected(position: position) {
         diceSet.setDie(selected: false, position: position)
      } else {
         diceSet.setDie(selected: true, position: position)
      }
      setDiceImages()
   }
   
   func setDiceImages(){
      var index = 1
      for button in diceButtonList{
         button.setBackgroundImage(getDiceImage(position: index), for: UIControl.State.normal)
         index += 1
      }
   }
   func getDiceImage(position: Int) -> UIImage? {
      var assetName = ""
      let diceValue = diceSet.valueAt(position: position)
      if diceValue == 1 {
         assetName = "dice-one"
      } else if diceValue == 2 {
         assetName = "dice-two"
      } else if diceValue == 3 {
         assetName = "dice-three"
      } else if diceValue == 4 {
         assetName = "dice-four"
      } else if diceValue == 5 {
         assetName = "dice-five"
      } else if diceValue == 6 {
         assetName = "dice-six"
      }
      
      if diceSet.dieIsSelectable(position: position){
         assetName.append("-selectable")
      }
      if diceSet.dieIsSelected(position: position) {
         assetName.append("-selected")
      }
      return UIImage.init(named: assetName)
   }
   
   func getScore(){
      scoreKeeper.currentRoll = scorer.getScoreForRoll(dice: diceSet)
      if scoreKeeper.currentRoll == 0 {
         scoreKeeper.currentScore = 0
      } else {
         scoreKeeper.currentScore += scoreKeeper.currentRoll
      }
      totalScoreField.text = String(scoreKeeper.currentScore)
      scoreFromRollField.text = String(scoreKeeper.currentRoll)
   }
   
}

