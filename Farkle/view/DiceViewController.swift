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
   @IBOutlet weak var dieOneButton: UIButton!
   @IBAction func dieOneButtonPressed(_ sender: Any) {
      toggleSelected(position: 1)
   }
   @IBOutlet weak var dieTwoButton: UIButton!
   @IBAction func dieTwoButtonPressed(_ sender: Any) {
      toggleSelected(position: 2)
   }
   @IBOutlet weak var dieThreeButton: UIButton!
   @IBAction func dieThreeButtonPressed(_ sender: Any) {
      toggleSelected(position: 3)
   }
   @IBOutlet weak var dieFourButton: UIButton!
   @IBAction func dieFourButtonPressed(_ sender: Any) {
      toggleSelected(position: 4)
   }
   @IBOutlet weak var dieFiveButton: UIButton!
   @IBAction func dieFiveButtonPressed(_ sender: Any) {
      toggleSelected(position: 5)
   }
   @IBOutlet weak var dieSixButton: UIButton!
   @IBAction func dieSixButtonPressed(_ sender: Any) {
      toggleSelected(position: 6)
   }
   func toggleSelected(position: Int) {
      if diceSet.dieIsSelected(position: position) {
         diceSet.setDie(selected: false, position: position)
      } else {
         diceSet.setDie(selected: true, position: position)
      }
      setDiceImages()
   }
   
   @IBOutlet weak var rollButton: UIButton!
   @IBAction func rollButtonPressed(_ sender: Any) {
      diceSet.roll()
      setDisabledImages()
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
      
      diceButtonList.append(dieOneButton)
      diceButtonList.append(dieTwoButton)
      diceButtonList.append(dieThreeButton)
      diceButtonList.append(dieFourButton)
      diceButtonList.append(dieFiveButton)
      diceButtonList.append(dieSixButton)
      
      setDisabledImages()
      setDiceImages()
      reset()
   }
   
   func reset() {
      for button in diceButtonList {
         button.isEnabled = false
      }
   }
   
   func setDisabledImages(){
      var index = 1
      for button in diceButtonList{
         button.setBackgroundImage(getDieImage(position: index, disabled: true), for: UIControl.State.disabled)
         index += 1
      }
   }
   
   func setDiceImages(){
      var index = 1
      for button in diceButtonList{
         button.setBackgroundImage(getDieImage(position: index, disabled: false), for: UIControl.State.normal)
         index += 1
      }
   }
   func getDieImage(position: Int, disabled: Bool) -> UIImage? {
      var assetName = ""
      let dieValue = diceSet.valueAt(position: position)
      if dieValue == 1 {
         assetName = "dice-one"
      } else if dieValue == 2 {
         assetName = "dice-two"
      } else if dieValue == 3 {
         assetName = "dice-three"
      } else if dieValue == 4 {
         assetName = "dice-four"
      } else if dieValue == 5 {
         assetName = "dice-five"
      } else if dieValue == 6 {
         assetName = "dice-six"
      }
      
      if disabled{
         assetName.append("-grayed")
      }
      else if diceSet.dieIsSelectable(position: position){
         assetName.append("-selectable")
      }
      else if diceSet.dieIsSelected(position: position) {
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
      //totalScoreField.text = String(scoreKeeper.currentScore)
      scoreFromRollField.text = String(scoreKeeper.currentRoll)
   }
   
}

