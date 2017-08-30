//
//  AddEmojisViewController.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 7/5/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit

protocol AddEmojisDelegate {
    func didAddEmojis(emojis: String, answers: Array<String>)
}

class AddEmojisViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emojisField: UITextField!
    
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer3: UITextField!
    
    var delegate: AddEmojisDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if (isValid()) {
            delegate?.didAddEmojis(emojis: emojisField.text!, answers: [answer1.text!, answer2.text!, answer3.text!])
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isValid() -> Bool {
        let redColor = UIColor.init(red: 255, green: 0, blue: 0, alpha: 0.15)
        if (emojisField.text == "") {
            emojisField.backgroundColor = redColor
            return false
        } else {
            emojisField.backgroundColor = UIColor.clear
        }
        
        if (answer1.text == "") {
            answer1.backgroundColor = redColor
            return false
        } else {
            answer1.backgroundColor = UIColor.clear
        }
        
        return true
    }
    
    func clearFields () {
        emojisField.text = ""
        answer1.text = ""
        answer2.text = ""
        answer3.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.accessibilityIdentifier == "emojis") {
            answer1.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
