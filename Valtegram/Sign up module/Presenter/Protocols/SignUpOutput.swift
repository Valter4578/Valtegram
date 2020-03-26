//
//  SignUpOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

protocol SignUpOutput {
    func createUser(email: String, password: String, imageToUpload: UIImage, data: Data, username: String)
    func uploadImage(image: UIImage, data: Data, uid: String, username: String) -> URL?
    func saveUserIntoDatabase(username: String, uid: String, imageUrl: URL?)
}
