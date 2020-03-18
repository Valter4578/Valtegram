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
        modifyItems()
    }
    
    func setupViewControllers() {
        // home view controller
        let homeNavigationController = createNavigationController(imageName: "home")
        // search view controller
        let searchNavigationController = createNavigationController(imageName: "search")
        // plus view controller
        let plusNavigationController = createNavigationController(imageName: "create")
        // liked view controller
        let likedNavigationController = createNavigationController(imageName: "heart")
        
        // profile view controller
        let collectionViewLayout = UICollectionViewFlowLayout()
        let userProfileViewController = UserProfileViewController(collectionViewLayout: collectionViewLayout)
        let userProfileNavigationController = createNavigationController(imageName: "profile", rootViewController: userProfileViewController)
        
        
        viewControllers = [homeNavigationController,searchNavigationController,plusNavigationController,likedNavigationController, userProfileNavigationController]
    }
    
    /// builder function that create navigation controllers for tab bart
    /// - Parameters:
    ///   - imageName: name of imag
    ///   - rootViewController: root view controller for navController
    private func createNavigationController(imageName: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = UIImage(named: imageName)
        
        let originalImage = UIImage(named: imageName+"-s")
        let img = originalImage?.tinted(with: UIColor.setAsRgb(red: 14, green: 186, blue: 129))
        navigationController.tabBarItem.selectedImage = img
        return navigationController
    }
    
    
    private func modifyItems() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}
