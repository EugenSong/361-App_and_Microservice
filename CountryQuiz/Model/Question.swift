//
//  Question.swift
//  CountryQuiz
//
//  Created by Eugene Song on 10/17/22.
//

import Foundation

// good practice: create new file to contain the Structure
// init like initializing classes

    struct Question {
        let text: String
        let answer: String
        
        init(q: String, a: String) {
            text = q
            answer = a
        }
    }
