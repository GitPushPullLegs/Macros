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

extension Date {
    func at(hours: Int, minutes: Int, seconds: Int) -> Date {
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        var dateComponents = calendar!.components([
            NSCalendar.Unit.year,
            NSCalendar.Unit.month,
            NSCalendar.Unit.day
        ], from: self)

        dateComponents.hour = hours
        dateComponents.minute = minutes
        dateComponents.second = seconds

        return calendar!.date(from: dateComponents)!
    }
}
