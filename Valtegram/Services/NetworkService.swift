//
//  NetworkService.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class NetworkService {
    class func getImage(from url: URL, complitionHandler: @escaping ((UIImage) -> Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                complitionHandler(image)
            }
        }.resume()
    }
}
