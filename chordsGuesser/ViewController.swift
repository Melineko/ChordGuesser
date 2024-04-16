//
//  ViewController.swift
//  chordsGuesser
//
//  Created by Melissa Briere on 13/02/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var baseView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imageMiddle: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        startButton.titleLabel?.minimumScaleFactor = 0.5
        startButton.layer.cornerRadius = startButton.frame.height * (1/5)
        displayHome()
        // Observe si le InGame a été dismissed
        NotificationCenter.default.addObserver(self, selector: #selector(resetHome), name: InGame_ViewController.dismissedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
            super.viewWillAppear(true)
        if GameModel.shared.roundNumber == 6 {
            print("nombre de tours au viewWill appear : \(GameModel.shared.roundNumber)")
            endingGame()
         }
        }
    // fonction pour le notificationCenter
    @objc func resetHome() {
        GameModel.shared.startGame()
        displayHome()
        print("Le stop a été tapé")
    }
    
    func endingGame() {
            //startButton.titleLabel?.text = "Restart"
            imageMiddle.image = UIImage(named: "brookFaceIllu")
        
        let level = GameModel.shared.score
        switch level {
        case 0 ..< 6:
            textLabel.text = "Peut mieux faire camerade."
        case 6..<10:
            textLabel.text = "On a le vent en poupe."
        default:
            textLabel.text = "Yohoho ! Pas mal l'ami."
        }
            scoreLabel.text = "Score: \(GameModel.shared.score)"
        }
    
    func displayHome() {
        startButton.titleLabel?.text = "Start"
        imageMiddle.image = UIImage(named: "mancheIllu")
        textLabel.text = "Devine l'accord !"
        scoreLabel.text = "Score: \(GameModel.shared.score)"
    }
    
            
    
}

