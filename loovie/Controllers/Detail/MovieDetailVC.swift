//
//  MovieDetailVC.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import Lottie

class MovieDetailVC: BaseVC {
    
    //Poster
    @IBOutlet private weak var animationView: AnimationView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Rating
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var imdbView: UIView!
    @IBOutlet weak var imdbTitleLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    
    @IBOutlet weak var tomatoView: UIView!
    @IBOutlet weak var tomatoTitleLabel: UILabel!
    @IBOutlet weak var tomatoRatingLabel: UILabel!
    
    @IBOutlet weak var metricView: UIView!
    @IBOutlet weak var metricTitleLabel: UILabel!
    @IBOutlet weak var metricRatingLabel: UILabel!
    
    //Explanations
    @IBOutlet weak var plotView: UIView!
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var releaseView: UIView!
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var awardsView: UIView!
    @IBOutlet weak var awardsLabel: UILabel!
    
    @IBOutlet weak var directorView: UIView!
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var boxofficeView: UIView!
    @IBOutlet weak var boxofficeLabel: UILabel!
    
    var imdbId: String!
    var movieDetail: DetailResponse?
    var na = "N/A"

    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetail()
    }
    
    //MARK: - Web Function
    func getMovieDetail() {
        self.startProgressHud()
        let request = DetailRequest(imdbID: imdbId)
        request.request(success: { (response) in
            self.stopProgressHud()
            self.movieDetail = response
            self.fill()
        }) { (error) in
            self.stopProgressHud()
            self.showErrorAlert(message: error.error)
        }
    }
    
    //MARK: - Fill UI
    func fill() {
        if let url = movieDetail?.poster {
            if url == na {
                animationView.isHidden = false
                animate()
            }else {
                posterImageView.setImageUrl(imageUrl: url)
                animationView.isHidden = true
            }
        }

        titleLabel.text = movieDetail?.title
        
        fillRatatings()
        
        let plot = movieDetail?.plot
        fillString(value: plot, label: plotLabel, view: plotView)
        let release = movieDetail?.released
        fillString(value: release, label: releaseLabel, view: releaseView)
        let awards = movieDetail?.awards
        fillString(value: awards, label: awardsLabel, view: awardsView)
        let director = movieDetail?.director
        fillString(value: director, label: directorLabel, view: directorView)
        let boxoffice = movieDetail?.boxOffice
        fillString(value: boxoffice, label: boxofficeLabel, view: boxofficeView)
        
    }
    
    func fillRatatings() {
        if let ratings = movieDetail?.ratings {
            ratingView.isHidden = false
            //imdb
            if ratings.count == 1 {
                imdbTitleLabel.text = ratings[0].source
                imdbRatingLabel.text = ratings[0].value
            }else {
                imdbTitleLabel.text = na
                imdbRatingLabel.text = na
            }
            //tomato
            if ratings.count == 2 {
                tomatoTitleLabel.text = ratings[1].source
                tomatoRatingLabel.text = ratings[1].value
            }else {
                tomatoTitleLabel.text = na
                tomatoRatingLabel.text = na
            }
            //metric
            if ratings.count == 3 {
                metricTitleLabel.text = ratings[2].source
                metricRatingLabel.text = ratings[2].value
            }else {
               metricTitleLabel.text = na
                metricRatingLabel.text = na
            }
        }else {
            ratingView.isHidden = true
        }
    }
    
    func fillString(value: String?, label: UILabel, view: UIView) {
        if value != na {
            view.isHidden = false
            label.text = value
        }else {
            view.isHidden = true
        }
    }

    //MARK: - Animate
    func animate() {
        let animation = Animation.named("notFound")
        animationView.loopMode = .loop
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
}
