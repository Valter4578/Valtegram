//
//  TabBarController.swift
//  Valtegram
//
//  Created by Максим Алексеев on 11.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileViewController(collectionViewLayout: collectionViewLayout)
        let navigationController = UINavigationController(rootViewController: userProfileController)
        
        navigationController.tabBarItem.image = UIImage(named: "profile_unselected")?.withRenderingMode(.automatic)
        navigationController.tabBarItem.selectedImage = UIImage(named: "profile_selected")?.withRenderingMode(.automatic)

        viewControllers = [navigationController, UIViewController()]
    }
}
