//
//  BaseVC.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

protocol BaseVCDelegate {
    func didAddRefresher(refresher: UIRefreshControl)
    func didRefresh()
}

class BaseVC: UIViewController {
    
    var baseDelegate: BaseVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setNavigationBarBackButtonEmpty()
        addAppIconToNavbar()
        view.backgroundColor = .mainBackground
    }
    
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(true)
           self.stopProgressHud()
       }
       
       func addRefresher() {
           let refresher = UIRefreshControl()
           refresher.tintColor = .spinnerColor
           refresher.addTarget(self, action: #selector(refreshed), for: .valueChanged)
           baseDelegate.didAddRefresher(refresher: refresher)
       }
       
       @objc func refreshed() {
           baseDelegate.didRefresh()
       }

}
