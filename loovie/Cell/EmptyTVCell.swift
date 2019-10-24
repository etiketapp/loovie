//
//  EmptyTVCell.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

class EmptyTVCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var titleLable: UILabel!
    
    var title: String! {
        didSet {
            titleLable.text = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
