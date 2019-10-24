//
//  CorneredView.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

@IBDesignable
class CorneredView: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        awakeFromNib()
    }
    
}
