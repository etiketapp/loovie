//
//  AlertExtension.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSuccessAlert(message: String) {
        self.performAlert(title: "Başarılı", message: message, buttonTitle: "Tamam", style: .alert)
    }
    
    func showErrorAlert(message: String) {
        self.performAlert(title: "Hata", message: message, buttonTitle: "Tamam", style: .alert)
    }
    
}
