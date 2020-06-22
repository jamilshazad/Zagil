//
//  ZATitleView.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 01/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import LBTATools

class ZATitleView: UIView {

    
    // MARK: - Class Properties
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    public var text: String? = nil {
        didSet {
            titleLabel.text = text
        }
    }
    public var image: UIImage? = nil {
        didSet {
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .white
        }
    }
    
    
    // MARK: - Initilization Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "ZATitleView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.fillSuperview()
    }

}
