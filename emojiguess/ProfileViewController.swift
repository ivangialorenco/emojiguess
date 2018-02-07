//
//  ProfileViewController.swift
//  emojiguess
//
//  Created by Ivan Gialorenco on 7/28/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseFacebookAuthUI
import FBSDKLoginKit

extension ProfileViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                return
            }

            self.performSegue(withIdentifier: "tabViewControllerSegue", sender: nil)
        }
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        if (self.tabBarController != nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fbLoginButton.readPermissions = ["public_profile", "email"]
        
        if (FBSDKAccessToken.current() != nil) {
            UserManager.sharedInstance.facebookInfo { (user) in
                self.title = user.fullName;
                
                if let checkedUrl = URL(string: user.profileURL!) {
                    self.userImage.contentMode = .scaleAspectFit
                    self.downloadImage(url: checkedUrl)
                }
                
                if (self.tabBarController != nil) {
                    return
                }
                
                self.performSegue(withIdentifier: "tabViewControllerSegue", sender: nil)
            }
        }
    }

    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.userImage.image = UIImage(data: data)
            }
        }
    }
}
