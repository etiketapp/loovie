//
//  UITableViewExtension.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

extension UITableView {
    
    func isEmpty(_ data: [Any]?) -> Bool {
        if data != nil && data!.count != 0 {
            return false
        }else {
            return true
        }
    }
    
    func scrollToTop() {
        self.setContentOffset(.zero, animated: true)
    }
    
}
