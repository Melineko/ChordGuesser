//
//  InGame-ViewController.swift
//  chordsGuesser
//
//  Created by Melissa Briere on 17/02/2024.
//

import UIKit

class InGame_ViewController: UIViewController {

    @IBOutlet weak var scoreLabelGame: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var chordImage: UIImageView!
    @IBOutlet weak var leftNoteLabel: UILabel!
    @IBOutlet weak var rightNoteLabel: UILabel!
    @IBOutlet weak var brookCommentLabel: UILabel!
    @IBOutlet weak var brookHeadImage: UIImageView!
    @IBOutlet weak var bandView: UIView!
    
    // notification pour le notification center
    static let dismissedNotification = Notification.Name("dismissed")
    
    var chordImageCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brookHeadImage.isHidden = false
        // Style
        stopButton.layer.cornerRadius = stopButton.frame.height * (1/5)
        leftNoteLabel.clipsToBounds = true
        leftNoteLabel.layer.cornerRadius = leftNoteLabel.frame.height * (1/5)
        rightNoteLabel.clipsToBounds = true
        rightNoteLabel.layer.cornerRadius = rightNoteLabel.frame.height * (1/5)
        
        GameModel.shared.startGame()
        GameModel.shared.newTurn()
        updateView()
        chordImage.isUserInteractionEnabled = true
      
    }
    
    func updateView() {
        chordImage.image = UIImage(named: GameModel.shared.rightAnswer)
        scoreLabelGame.text = "Score : \(GameModel.shared.score)"
        leftNoteLabel.text = GameModel.shared.answers[0]
        rightNoteLabel.text = GameModel.shared.answers[1]
        brookCommentLabel.text = GameModel.shared.brookComment
        leftNoteLabel.textColor = .black
        leftNoteLabel.backgroundColor = .clear
        rightNoteLabel.textColor = .black
        rightNoteLabel.backgroundColor = .clear
    }
    
    // TOUCHES -----------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let first = touches.first {
            if first.view == chordImage {
                if chordImage.isUserInteractionEnabled == true {
                    guard chordImageCenter == nil else { return }
                    chordImageCenter = chordImage.center
                }
                print("le touch a began")
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let center = getTouch(touches: touches) else { return }
        //pour éviter le déplacement en Y
        if let chordCenter = chordImageCenter {
            let y = chordCenter.y
            let x = center.x
            chordImage.center = CGPoint(x: x, y: y) } else { return }
        
        let index = leftOrRight(x: center.x)
        switch index {
        case 0: brookHeadImage.image = UIImage(named: "brookLeftIllu")
            changeColorLabel(labelSelected: leftNoteLabel, labelUnselected: rightNoteLabel)
            GameModel.shared.answerSelected = leftNoteLabel.text!
            print("le touch a moove à gauche")
        case 1: brookHeadImage.image = UIImage(named: "brookRightIllu")
            changeColorLabel(labelSelected: rightNoteLabel, labelUnselected: leftNoteLabel)
            GameModel.shared.answerSelected = rightNoteLabel.text!
            print("le touch a moove à droite")
        default: brookHeadImage.image = UIImage(named: "brookLeftIllu")
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let center = getTouch(touches: touches) else { return }
        if let chordCenter = chordImageCenter {
            chordImage.center = chordCenter // reviens au centre
        } else { return }
        
        print("le touch est fini")
        let sideAnswer = leftOrRight(x: center.x)
        if sideAnswer != 3 {
            if GameModel.shared.isCorrect {
                GameModel.shared.score += 2
            }
            if GameModel.shared.roundNumber < 6 {
                GameModel.shared.roundNumber += 1
                GameModel.shared.newTurn()
                updateView()
            } else {
                // end of party
                chordImage.isUserInteractionEnabled = false
                brookHeadImage.image = UIImage(named: "brookFaceIllu")
                dismiss(animated: true, completion: nil)
            }
        }

    }
    // fonctions pour TOUCHES
    func getTouch(touches: Set<UITouch>) -> CGPoint? {
        guard let touch = touches.first else { return nil }
        let center = touch.location(in: self.view)
        return center
    }
    //pour déplacement image
    func leftOrRight(x: CGFloat) -> Int {
        let viewX = self.view.center.x
        let valueX = viewX - x
        print(valueX)// négative : droite / positive: gauche
        if valueX > 100 {
            return 0
        } else if valueX < -100 {
            return 1
        } else {
            return 2
        }
    }
    
    func changeColorLabel (labelSelected: UILabel, labelUnselected: UILabel) {
        labelSelected.backgroundColor = .black
        labelSelected.textColor = .white
        labelUnselected.backgroundColor = .clear
        labelUnselected.textColor = .black
    }
    
    // ACTIONS
    @IBAction func tapStop(_ sender: UIButton) {
        dismiss(animated: true) {
            NotificationCenter.default.post(name: InGame_ViewController.dismissedNotification, object: nil)}
    }
    

}
