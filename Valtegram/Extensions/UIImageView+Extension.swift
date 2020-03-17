//
//  UIImageView+Extension.swift
//  Valtegram
//
//  Created by Максим Алексеев on 11.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

extension UIImage {
    func tinted(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
}
