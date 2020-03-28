//
//  HomeFeedAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 28.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class HomeFeedAssembly {
    class func configureModule() -> HomeFeedViewController {
        let presenter = HomeFeedPresenter()
    
        let layout = UICollectionViewFlowLayout()
        let view = HomeFeedViewController(collectionViewLayout: layout)
        view.presenter = presenter
        
        return view
    }
}
