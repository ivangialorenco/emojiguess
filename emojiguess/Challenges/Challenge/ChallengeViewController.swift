//
//  EGChallengeViewController.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/8/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChallengeViewController: UIViewController {
    var challenge: Challenge?
    var challengeManager: ChallengeManager?
    var keyboardSize: CGRect = CGRect()
    
    @IBOutlet weak var challengeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = challenge?.title
        challengeTableView.tableFooterView = UIView()
        challengeManager = ChallengeManager()
        
        challengeManager?.loadChallengeItems(challenge: challenge!, completion: { (challengeItems) in
            self.challenge?.items = challengeItems
            self.challengeTableView.reloadData()
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
}

// MARK: Private Methods
private extension ChallengeViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            keyboardSize = keyboardFrame.cgRectValue
        }
    }
}

// MARK: TableViewDataSource
extension ChallengeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (challenge?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChallengeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "challengeCell") as! ChallengeTableViewCell
        let challengeItem = challenge?.items[indexPath.row]
        
        cell.emojis.text = challengeItem?.emojis
        cell.challengeItem = challengeItem
        
        return cell
    }
}

// MARK: TableViewDelegate
extension ChallengeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:ChallengeTableViewCell = tableView.cellForRow(at: indexPath) as! ChallengeTableViewCell
        cell.enterAnswerMode()
        
        // scroll tableview to show emoji
        let pointInTable:CGPoint = cell.answerField.superview!.convert(cell.answerField.frame.origin, to:tableView)
        var contentOffset:CGPoint = tableView.contentOffset
        
        guard (pointInTable.y > (tableView.frame.size.height - keyboardSize.height)) else {
            return
        }
        
        contentOffset.y = pointInTable.y - keyboardSize.size.height
        if let accessoryView = cell.answerField.inputAccessoryView {
            contentOffset.y -= accessoryView.frame.size.height
        }
        
        tableView.contentOffset = contentOffset
    }
}
