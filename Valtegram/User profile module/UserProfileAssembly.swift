//
//  UserProfileAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class UserProfileAssembly {
    class func configureModule() -> UIViewController {
        let view = UserProfileViewController()
        let presenter = UserProfilePresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
