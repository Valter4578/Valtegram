//
//  SearchAssembly.swift
//  Valtegram
//
//  Created by Максим Алексеев on 02.04.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class SearchAssembly {
    class func configureModule() -> SearchCollectionViewController {
        let layout = UICollectionViewFlowLayout()
        let view = SearchCollectionViewController(collectionViewLayout: layout)
        let presenter = SearchPresenter()
        view.presenter = presenter
        return view
    }
}
