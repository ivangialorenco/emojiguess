//
//  EGChallengeTableViewCell.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/8/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var emojis: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var checkmark: UIImageView!
    
    var challengeItem: ChallengeItem? {
        didSet {
            answerField.text = challengeItem?.answer
            checkAnswer()
        }
    }
    
    override func prepareForReuse() {
        answerField.delegate = self
        answerField.isHidden = true
        checkmark.isHidden = true
        answerField.text = challengeItem?.answer
        
        checkAnswer()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        answerField.delegate = self
        answerField.isHidden = true
        checkmark.isHidden = true
        answerField.text = challengeItem?.answer
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       enterAnswerMode()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkAnswer()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkAnswer()
        
        return true
    }
    
    func checkAnswer() {
        if (challengeItem?.isCorrectedAnswered(currentAnswer: answerField.text!))! {
            correctlyAnsweredMode()
        } else {
            defaultMode()
        }
        
        answerField.resignFirstResponder()
        isSelected = false
    }
    
    func enterAnswerMode() {
        answerField.becomeFirstResponder()
        answerMode()
    }
    
    func exitAnswerMode() {
        answerField.resignFirstResponder()
        
        defaultMode()
    }
    
    func defaultMode () {
        isUserInteractionEnabled = true
        answerField.isHidden = challengeItem?.answer == "";
        emojis.alpha = 1
        checkmark.isHidden = true
        answerField.textAlignment = .right
    }
    
    func answerMode () {
        answerField.isHidden = false
        emojis.alpha = 0.3
        checkmark.isHidden = true
        answerField.textAlignment = .center
    }
    
    func correctlyAnsweredMode () {
        answerMode ()
        
        isUserInteractionEnabled = false
        checkmark.isHidden = false
    }
}
