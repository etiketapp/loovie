//
//  ViewControllers.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

struct ViewControllers {
    
    struct Search {
        private static var storyBoardName = SearchVC.identifier
        static var searchVC: SearchVC {
            return ViewControllers.getViewController(storyBoardName: storyBoardName, viewControllerId: SearchVC.identifier) as! SearchVC
        }
    }
    
    fileprivate static func getViewController(storyBoardName: String, viewControllerId: String) -> UIViewController? {
        let sb = UIStoryboard(name: storyBoardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewControllerId)
        return vc
    }
    
    fileprivate static func getNavigationController(storyBoardName: String, viewControllerId: String) -> UINavigationController? {
        let sb = UIStoryboard(name: storyBoardName, bundle: nil)
        let nc = sb.instantiateViewController(withIdentifier: viewControllerId) as! UINavigationController
        return nc
    }
    
    fileprivate static func getTabBarController(storyBoardName: String, viewControllerId: String) -> UITabBarController? {
        let sb = UIStoryboard(name: storyBoardName, bundle: nil)
        let nc = sb.instantiateViewController(withIdentifier: viewControllerId) as! UITabBarController
        return nc
    }
    
}
