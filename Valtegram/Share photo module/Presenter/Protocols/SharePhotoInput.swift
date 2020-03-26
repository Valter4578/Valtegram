//
//  SharePhotoInput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol SharePhotoInput: class {
    var navigationItem: UINavigationItem { get set }
    
    func handleShareButton()
    func cancel(animated: Bool)
}
