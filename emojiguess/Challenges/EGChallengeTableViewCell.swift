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
    
    var correctAnswer: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        answerField.delegate = self
        answerField.isHidden = true
        checkmark.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if isCorrectedAnswered() {
            return
        }
        
        if selected {
            answerField.isHidden = false
            answerField.becomeFirstResponder()
            emojis.alpha = 0.5
        } else {
            answerField.isHidden = true
            emojis.alpha = 1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if isCorrectedAnswered() {
            checkmark.isHidden = false
            isUserInteractionEnabled = false
        } else {
            answerField.textColor = UIColor.black
        }
    }
    
    func isCorrectedAnswered() -> Bool {
        return correctAnswer?.lowercased() == answerField.text!.lowercased()
    }
}
