//
//  Extensions.swift
//  Macros
//
//  Created by Jose Aguilar on 5/4/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import UIKit

extension UIImage {
    static func fromColor(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return colorImage
        }
        return nil
    }
}
