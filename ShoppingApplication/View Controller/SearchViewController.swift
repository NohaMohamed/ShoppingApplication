//
//  ViewController.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 18/08/2022.
//

import UIKit
protocol SearchViewProtocol : AnyObject ,LoadingViewCapable{
    func didRecieveProducts()
    func didRecieveError(_ message: String)
}
final class SearchTableViewController: UITableViewController {
    //MARK: Dependencies
    private var searchTask: DispatchWorkItem?
    let cellIdentifier: String = "ProductTableViewCell"
    let dispatchTime: DispatchTime = DispatchTime.now() + 0.5
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var presenter : SearchPresenterToViewProtocol = {
        let searchPresenter = SearchPresenter(service: SearchService())
        searchPresenter.view = self
        return searchPresenter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setSearchBarView()
    }
    private func setupTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchTableViewController: SearchViewProtocol{
    func didRecieveError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showError(message: message)
        }
    }
    
    func didRecieveProducts() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
// Search Logic
extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBarText = searchController.searchBar.text
        guard let text = searchBarText, !text.isEmpty else {
            self.presenter.resetProducts()
            self.searchTask?.cancel()
            return
        }
        configureSearchTask(text: text)
    }
    //End previous search task aand send another reuquest after 0.5
    func configureSearchTask(text: String) {
        self.searchTask?.cancel()
        self.presenter.resetProducts()
        let task = DispatchWorkItem { [weak self] in
            // Send new request for search based on the text
            self?.presenter.search(text)
        }
        self.searchTask = task
        
        DispatchQueue.global().asyncAfter(deadline: dispatchTime, execute: task)
    }
    
}
