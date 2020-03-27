//
//  SharePhotoOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol SharePhotoOutput {
    func didPressShare(text: String, image: UIImage)
    func savePostIntoDatabase(url: URL, postImage: UIImage, text: String)
}
