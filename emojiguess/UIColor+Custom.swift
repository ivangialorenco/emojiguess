//
//  UIColor.swift
//  EmojiGuess
//
//  Created by Ivan Gialorenco on 11/9/17.
//  Copyright © 2017 MyAppTemplates. All rights reserved.
//

import UIKit

extension UIColor {
    static let mainColor = UIColor.init(red:248, green:202, blue:51)
    static let secundaryColor = UIColor.init(red: 110, green: 182, blue: 218)
    static let thirdColor = UIColor.init(red: 19, green: 41, blue: 77)
    
    static let emojiYellow = UIColor.init(red:248, green:202, blue:51)
    static let correctAnswer = UIColor.
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
