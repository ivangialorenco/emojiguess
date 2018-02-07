//
//  NewChallengeViewController.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/29/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit

class NewChallengeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AddEmojisDelegate {
    
    @IBOutlet weak var challengeTitleTextField: UITextField!
    @IBOutlet weak var addEmojiTapped: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var emojisTableView: UITableView!
    
    var emojisRegistered:[ChallengeItem] = []
    var editedChallenge:Challenge?
    var emojiSelected:ChallengeItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.editedChallenge != nil) {
            self.emojisRegistered = (self.editedChallenge?.items)!
            self.challengeTitleTextField.text = self.editedChallenge?.title
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojisRegistered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"emojiCell", for: indexPath)
        let challengeItem = emojisRegistered[indexPath.row]
        cell.textLabel?.text = challengeItem.emojis
        cell.detailTextLabel?.text = challengeItem.answersToString()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.emojiSelected = emojisRegistered[indexPath.row]
        self.performSegue(withIdentifier: "addEmojiSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let challengeItem = (emojisRegistered[indexPath.row] as ChallengeItem)
            if (challengeItem.ref != nil) {
                challengeItem.ref?.removeValue()
            } else {
                self.emojisRegistered.remove(at: indexPath.row)
            }
            
            self.emojisTableView.reloadData()
        }
        
        if editingStyle == .insert {
            self.emojisTableView.reloadData()
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let challengeManager = ChallengeManager()
        
        var challenge:Challenge!
        
        if (self.editedChallenge == nil) {
            challenge = Challenge(title: challengeTitleTextField.text!, creatorName: (UserManager.sharedInstance.user?.fullName)!, items: emojisRegistered, key: "")
        } else {
            self.editedChallenge?.items = self.emojisRegistered
            self.editedChallenge?.title = self.challengeTitleTextField.text!
            challenge = self.editedChallenge
        }
        
        challengeManager.createChallenge(challenge: challenge) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        self.editedChallenge?.ref?.removeValue()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        challengeTitleTextField.resignFirstResponder()
        
        let addEmojiVC: AddEmojisViewController = segue.destination as! AddEmojisViewController
        if let emojiSelected = self.emojiSelected {
            addEmojiVC.emojiLoaded = emojiSelected
        }
        addEmojiVC.delegate = self
    }
    
    func didAddEmojis(key: String, emojis: String, answers: Array<String>) {
        if (key == "") {
            emojisRegistered.append(ChallengeItem(emojis: emojis, correctAnswers: answers, key: key))
        } else {
            emojisRegistered.remove(at: Int(key)!)
            emojisRegistered.insert(ChallengeItem(emojis: emojis, correctAnswers: answers, key: key), at: Int(key)!)
        }
        
        emojisTableView.reloadData()
        self.emojiSelected = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

