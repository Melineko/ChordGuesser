//
//  GameModel.swift
//  chordsGuesser
//
//  Created by Melissa Briere on 13/02/2024.
//

import Foundation

class GameModel {
    
    // singleton
    static let shared = GameModel()
    private init() {}
    
    // properties
    var score: Int = 0
    var roundNumber: Int = 0
    var brookComment = "Mmmmh..."
    private var chords: [String] = ["Do", "Ré", "Mi", "Fa", "Sol", "La", "Si"]
    private var currentChord: String = ""
    var rightAnswer :String {
        get { return currentChord }
    }
    var wrongAnswer: String {
        get {
            var randomNote = chords.randomElement()!
            if randomNote == currentChord { randomNote = chords.randomElement()! }
            return randomNote
        }
    }
    var answers = [""]
    var answerSelected: String?
    var isCorrect: Bool {
        get {
            if answerSelected == rightAnswer {
                brookComment = "Yohoho !"
                return true
            } else {
                brookComment = "Oups"
                return false
            }
        }
    }
    // methods
    func startGame() {
        score = 0
        roundNumber = 0
        chords.shuffle()
    }
    
    func newTurn() {
        currentChord = chords[roundNumber]
        answerRepart()
    }
    
    private func answerRepart() {
        answers = [rightAnswer, wrongAnswer]
        answers.shuffle()
    }
    
}
