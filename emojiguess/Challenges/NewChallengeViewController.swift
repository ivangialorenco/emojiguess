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
    @IBOutlet weak var emojisTableView: UITableView!
    
    var emojisRegistered:[ChallengeItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojisRegistered.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"emojiCell", for: indexPath)
        let challengeItem = (emojisRegistered[indexPath.row] as ChallengeItem)
        cell.textLabel?.text = challengeItem.emojis
        cell.detailTextLabel?.text = challengeItem.answersToString()
        
        return cell
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let challengeManager = ChallengeManager()
        challengeManager.createChallenge(challenge: Challenge(title: challengeTitleTextField.text!, creatorName: (UserManager.sharedInstance.user?.fullName)!, items: emojisRegistered, key: "")) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        challengeTitleTextField.resignFirstResponder()
        
        let addEmojiVC: AddEmojisViewController = segue.destination as! AddEmojisViewController
        addEmojiVC.delegate = self
    }
    
    func didAddEmojis(emojis: String, answers: Array<String>) {
        emojisRegistered.append(ChallengeItem(emojis: emojis, correctAnswers: answers))
        
        emojisTableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

