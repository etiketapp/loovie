//
//  UIViewExtension.swift
//  loovie
//
//  Created by tunay alver on 25.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    func popView(duration: Double){
        self.transform = CGAffineTransform(scaleX: 2, y: 2)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .repeat,  animations: {
            self.transform = .identity
        })
    }
    
}
