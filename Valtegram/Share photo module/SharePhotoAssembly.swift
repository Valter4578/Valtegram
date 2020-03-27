//
//  SharePhotoAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Foundation

class SharePhotoAssembly {
    class func configureModule() -> SharePhotoViewController {
        let view = SharePhotoViewController()
        let presenter = SharePhotoPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
}
