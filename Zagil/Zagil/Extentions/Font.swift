//
//  Font.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum Font {
    case ooredoo
    case segoe
}
extension UIFont {
    
    class func regular(fontSize: CGFloat = 17, font: Font = .ooredoo) -> UIFont {
        switch font {
        case .ooredoo: return R.font.ooredooRegular(size: fontSize)!
        case .segoe: return R.font.segoeUI(size: fontSize)!
        }
    }
    
    class func bold(fontSize: CGFloat = 17, font: Font = .ooredoo) -> UIFont {
        switch font {
        case .ooredoo: return R.font.ooredooBold(size: fontSize)!
        case .segoe: return R.font.segoeUIBold(size: fontSize)!
        }
    }
    
}
