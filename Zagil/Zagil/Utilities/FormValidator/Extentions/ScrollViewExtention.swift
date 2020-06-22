//
//  ScrollViewExtention.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    
    // MARK: - Public Methods
    
    public func scrollTo(_ view: UIView, animated: Bool = true) {
        if let origin = view.superview {
            let startPoint = origin.convert(view.frame.origin, to: self)
            let rect = CGRect(x: 0, y: startPoint.y - 10, width: 1, height: frame.height)
            scrollRectToVisible(rect, animated: animated)
        }
    }
    
    public func scrollToTop(animated: Bool = true) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if bottomOffset.y > 0 {
            setContentOffset(bottomOffset, animated: animated)
        }
    }
}
