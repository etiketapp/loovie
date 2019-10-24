//
//  SearchVC.swift
//  loovie
//
//  Created by tunay alver on 24.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

class SearchVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    var movies: [BaseResponse]?
    var tappedMovie: BaseResponse!
    
    var isLoading: Bool! = true
    var refresher: UIRefreshControl!
    var page = 1
    var responseCount: Int!
    
    var searchString: String? {
        didSet {
            searchBy(searchString, page: page)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        searchString = nil
    }
    
    //MARK: - Prepare
    func prepareViews() {
        self.baseDelegate = self
        self.addRefresher()
        tableView.register(SearchTVCell.self)
        tableView.register(MovieTVCell.self)
        tableView.register(EmptyTVCell.self)
    }
    
    //MARK: - Fetch Movies
    func searchBy(_ searchString: String?, page: Int?) {
        guard searchString != nil else {
            self.movies = nil
            self.refresher.endRefreshing()
            self.tableView.reloadData()
            return
        }
        self.startProgressHud()
        let request = SearchRequest(searchString: searchString, page: page)
        request.request(success: { (response) in
            self.stopProgressHud()
            self.refresher.endRefreshing()
            self.isLoading = false
            
            //NOTE: - Unable to get total data for pagination...
//            self.res = response.totalResults
//            self.totalResults = Int(response.totalResults)
            if self.page == 1 {
                self.movies = response.search
            }else {
                self.movies?.append(contentsOf: response.search!)
            }
            self.responseCount = response.search?.count
            
            self.tableView.reloadData()
        }) { (error) in
            self.stopProgressHud()
            self.refresher.endRefreshing()
            self.isLoading = false
            self.showErrorAlert(message: error.error)
        }
    }
}

//MARK: - TableView Delegate, DataSource
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    
    enum Sections: Int {
        case search
        case movie
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = tableView.frame.width
        switch Sections(rawValue: indexPath.section)! {
        case .search:
            return UITableView.automaticDimension
        case .movie:
            return width * 2/3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section)! {
        case .search:
            return 1
        case .movie:
            if tableView.isEmpty(movies) && !isLoading {
                return 1
            }else {
                return movies?.count ?? 0
            }
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section)! {
        case .search:
            let cell: SearchTVCell = tableView.dequeueReusableCell()
            cell.delegate = self
            return cell
        case .movie:
            if tableView.isEmpty(movies) && !isLoading {
                let cell: EmptyTVCell = tableView.dequeueReusableCell()
                cell.title = "Please type the search parameter."
                return cell
            }else {
                let cell: MovieTVCell = tableView.dequeueReusableCell()
                cell.movie = movies?[indexPath.row]
                return cell
            }
        }
    }
    
    //MARK: - Will Display
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.movies?.count && responseCount > 9 {
            self.page += 1
            self.searchBy(searchString, page: self.page)
        }
    }
    
    //Didselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? MovieTVCell) != nil {
            self.tappedMovie = movies?[indexPath.row]
            self.performSegue(withIdentifier: MovieDetailVC.identifier, sender: nil)
        }
    }
    
}

//MARK: - Prepare
extension SearchVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailVC {
            destination.imdbId = self.tappedMovie.imdbID
        }
    }
}

//MARK: - Search
extension SearchVC: SearchTVCellDelegate {
    func didSearch(searchString: String?) {
        self.page = 1
        self.searchString = searchString
    }
}

//MARK: - Refresher
extension SearchVC: BaseVCDelegate {
    
    func didAddRefresher(refresher: UIRefreshControl) {
        self.refresher = refresher
        self.tableView!.addSubview(refresher)
    }
    
    func didRefresh() {
        self.page = 1
        searchBy(searchString, page: page)
    }
    
}
