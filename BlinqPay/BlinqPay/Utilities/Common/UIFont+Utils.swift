//
//  UIFont+Utils.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import UIKit

extension UIFont {
    class func productSansBold(size: CGFloat = 14) -> UIFont { UIFont(name: "ProductSans-Bold", size: size) ?? UIFont.systemFont(ofSize: size) }
    
    class func productSansRegular(size: CGFloat = 14) -> UIFont { UIFont(name: "ProductSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size) }
}
