//
//  SearchTVCell.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

protocol SearchTVCellDelegate {
    func didSearch(searchString: String?)
}

class SearchTVCell: UITableViewCell, NibLoadableView, ReusableView, UISearchBarDelegate {
    
     @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: SearchTVCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        delegate.didSearch(searchString: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.endEditing(true)
            delegate.didSearch(searchString: nil)
        }
    }
    
}
