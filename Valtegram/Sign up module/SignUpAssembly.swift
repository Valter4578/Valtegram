//
//  SignUpAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class SignUpAssembly {
    class func configureModule() -> SignUpViewController {
        let view = SignUpViewController()
        let presenter = SignUpPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
}
