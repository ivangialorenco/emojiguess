//
//  EGTabBarController.swift
//  emojiguess
//
//  Created by Ivan Gialorenço on 6/6/17.
//  Copyright © 2017 Arctouch. All rights reserved.
//

import UIKit
import FontAwesomeKit

class EGTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iconSize:CGFloat = 18.0
        
        let icon1:FAKIcon = FAKFontAwesome.smileOIcon(withSize: iconSize)
        let icon1Image:UIImage = icon1.image(with: CGSize(width: iconSize, height: iconSize))
        self.tabBar.items![0].image = icon1Image
        
        let icon2:FAKIcon = FAKFontAwesome.listOlIcon(withSize: iconSize)
        let icon2Image:UIImage = icon2.image(with: CGSize(width: iconSize, height: iconSize))
        self.tabBar.items![1].image = icon2Image
        
        let icon3:FAKIcon = FAKFontAwesome.userIcon(withSize: iconSize)
        let icon3Image:UIImage = icon3.image(with: CGSize(width: iconSize, height: iconSize))
        self.tabBar.items![2].image = icon3Image
        self.tabBar.items![2].title = (UserManager.sharedInstance.user?.firstName)! + " " + (UserManager.sharedInstance.user?.lastName)!
    }
}
