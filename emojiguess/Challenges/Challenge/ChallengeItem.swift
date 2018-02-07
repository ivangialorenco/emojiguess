//
//  ChallengeItem.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/28/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChallengeItem: NSObject {
    
    let key: String
    var emojis: String
    var answer: String
    var correctAnswers: [String] = []
    let ref:DatabaseReference?
    
    init(emojis: String, answer: String = "", correctAnswers: [String], key: String = "") {
        self.emojis = emojis
        self.answer = answer
        self.correctAnswers = correctAnswers
        self.key = key
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        emojis = snapshotValue["emojis"] as! String
        correctAnswers = snapshotValue["correctAnswers"] as! [String]
        answer = ""
        ref = snapshot.ref
    }
    
    func isCorrectedAnswered(currentAnswer: String) -> Bool {
        answer = currentAnswer;
        
        for correctAnswer in correctAnswers {
            if correctAnswer != "" && correctAnswer.lowercased() == answer.lowercased() {
                return true
            }
        }
        
        return false
    }
    
    func answersToString() -> String {
        var answersString = ""
        for correctAnswer in correctAnswers {
            if correctAnswer != "" {
                if (answersString != "") {
                    answersString += ", "
                }
                
                answersString += correctAnswer
            }
        }
        
        return answersString
    }
    
    func toAnyObject() -> (challengeItem: Any, key: Any) {
        return (
            challengeItem: ["emojis": emojis, "correctAnswers": correctAnswers],
            key: ""
        )
    }
}
