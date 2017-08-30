//
//  EGHomeViewController.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/8/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var challengesTableView: UITableView!
    @IBOutlet weak var newChallengeButton: UIButton!
    
    var challengeManager: ChallengeManager?
    var selectedChallenge: Challenge?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        challengeManager = ChallengeManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeManager?.loadChallenges(completion: {
            self.challengesTableView.reloadData()
        })
        
        challengesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        challengesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (challengeManager?.challenges.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"challengeCell", for: indexPath) as! ChallengeListTableViewCell
        
        cell.title?.text = challengeManager?.challenges[indexPath.row].title
        cell.numberOfItemsLabel?.text = String(format: "%ld desafios", (challengeManager?.challenges[indexPath.row].items.count)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChallenge = challengeManager?.challenges[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "challengeViewControllerSegue", let destination = segue.destination as? ChallengeViewController {
            if let cell = sender as? UITableViewCell, let indexPath = challengesTableView.indexPath(for: cell) {
                selectedChallenge = challengeManager?.challenges[indexPath.row]
                destination.challenge = selectedChallenge
            }
        }
    }
}
