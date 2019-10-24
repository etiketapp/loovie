//
//  MovieTVCell.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import Lottie

class MovieTVCell: UITableViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var imdbLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    var movie: BaseResponse! {
        didSet {
            if let url = movie.poster {
                if url == "N/A" {
                    animationView.isHidden = false
                    animate()
                }else {
                    movieImageView.setImageUrl(imageUrl: url)
                    animationView.isHidden = true
                }
            }
            titleLabel.text = movie.title
            imdbLabel.text = movie.imdbID
            typeLabel.text = movie.type
            yearLabel.text = movie.year
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Functions
    func animate() {
        let animation = Animation.named("notFound")
        animationView.loopMode = .loop
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
    
}
