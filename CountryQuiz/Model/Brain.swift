//
//  Brain.swift
//  CountryQuiz
//
//  Created by Eugene Song on 10/17/22.
//

import Foundation

struct Brain {
    let quiz = [
        // he is a clownfish
        Question(q: "In the animation film “Finding Nemo,” the main protagonist is a pufferfish.", a: "False",k: "Finding Nemo"),
        
        // In general, Italian nouns that end in “o” are single in nature, whereas those that finish in “i” are plural. Spaghetti is made using a large amount of spaghetto.
        Question(q: "Spaghetto is the singular form of the word spaghetti.", a: "True", k: "Spaghetti"),
        
        // The first one was Snow White and the Seven Dwarfs.
        Question(q: "Pinocchio was Walt Disney’s first animated feature film in full color.", a: "False", k: "Pinocchio"),
        
        Question(q: "The mosquito has a record for killing more people than any other species in written history.", a: "True", k: "mosquito"),
        
        // When coffee berries were riped, they are harvested, processed, and dried before being roasted and ground into coffee.
        Question(q: "Coffee is a berry-based beverage.", a: "True", k:"coffee berries"),
        
        // Amazon is the largest; the Nile is the longest.
        Question(q: "The longest river in the world is the Amazon River.", a: "False", k:"Nile River"),
        
        // The King of Hearts has no mustache.
        Question(q: "In a regular deck of cards, all kings have a mustache.", a: "False", k:"King of Hearts")
    ]
    
    var questionNumber = 0
    var score = 0
    
    mutating func checkAnswer(userAnswer:String) -> Bool {
        // UI colors are prebuilt colors
        if userAnswer == quiz[questionNumber].answer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getQuestionKeyword() -> String {
        return quiz[questionNumber].keyword
    }
    
    func getProgress() -> Float {
        let progress = Float(questionNumber + 1)  / Float(quiz.count)
        return progress
    }
    
    mutating func nextQuestion() {
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        }
        else {
            questionNumber = 0
            
            // reset score here when questions reset..
            score = 0
        }
    }
    
    mutating func getQuestionNumber() -> Int {
        return questionNumber
    }
    
    // getter
    mutating func getScore() -> Int {
        return score
    }
    
}
