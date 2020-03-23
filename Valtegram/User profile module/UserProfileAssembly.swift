//
//  UserProfileAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class UserProfileAssembly {
    class func configureModule() -> UserProfileViewController {
        let layout = UICollectionViewFlowLayout()
        let viewController = UserProfileViewController(collectionViewLayout: layout)
        
        let presenter = UserProfilePresenter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
}
