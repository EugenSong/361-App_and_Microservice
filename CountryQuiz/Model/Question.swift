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
        let keyword: String
        
        init(q: String, a: String, k: String) {
            text = q
            answer = a
            keyword = k
        }
    }
