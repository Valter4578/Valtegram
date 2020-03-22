//
//  LoginAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class LoginAssembly {
    class func configureModule() -> UIViewController {

        let view = LogInViewController()
    
        let presenter = LoginPresenter()
        presenter.view = view
        
        view.presenter = presenter
        
        return view
    }
}
