//
//  MainVC.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import Lottie
import Firebase
import Alamofire

class MainVC: BaseVC {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var loadingDoneCallback: ((_ value: String) -> Void)?
    var remoteConfig: RemoteConfig!
    var fetchComplete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
        self.titleLabel.text = "Loading..."
        if isConnected() {
            getTitleValue()
        }else {
            self.titleLabel.text = "Check your connection please."
        }
    }
    
    func isConnected() -> Bool {
       return NetworkReachabilityManager()!.isReachable
    }
    
    func getTitleValue() {
        //NOTE: - async for only to visualyze better
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchCloudValues { (value) in
                self.titleLabel.fadeTransition(0.5)
                self.titleLabel.text = value
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.performSegue(withIdentifier: SearchVC.identifier, sender: nil)
                }
            }
        }
    }
    
    //MARK: - Fetch
    func fetchCloudValues(done: @escaping(String) -> Void) {
        var value: String?
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { (status, error) in
            if error != nil {
                self.showErrorAlert(message: error?.localizedDescription ?? "Error happened.")
                return
            }
            self.remoteConfig.activate { (error) in
                if error != nil {
                    let key = self.remoteConfig.configValue(forKey: "loodosKey")
                    let string = key.stringValue
                    value = string
                    DispatchQueue.main.async {
                       done(value ?? "Loading...")
                    }
                }
            }
        }
    }
    
    //MARK: - Animate
    //NOTE: - This could be extension too !
    func animate() {
        logoImageView.popView(duration: 1.5)
        let animation = Animation.named("lightsaber")
        animationView.loopMode = .loop
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }

}
