//
//  PhotoSelectorAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class PhotoSelectorAssembly {
    class func configureModule() -> PhotoSelectorViewController {
        let layout = UICollectionViewFlowLayout()
        let view = PhotoSelectorViewController(collectionViewLayout: layout)
        let presenter = PhotoSelectorPresenter()
        view.presenter = presenter
        
        return view
    }
}
