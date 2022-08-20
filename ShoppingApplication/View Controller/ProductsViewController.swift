//
//  ViewController.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 18/08/2022.
//

import UIKit
protocol ProductsViewProtocol : AnyObject {
    func showProducts()
}
class ProductsViewController: UIViewController {
    
    //MARK: Outelts
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsTableview: UITableView!
    
    //MARK: Variables
    private var searchTask: DispatchWorkItem?
    let cellIdentifier: String = "ProductTableViewCell"
    
    lazy var presenter =  ProductsPresenter(service: ProductsService(apiClient: APICleint.shared))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.view = self
        setupTableView()
    }
    private func setupTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        productsTableview.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        searchBar.delegate = self
        productsTableview.delegate = self
        productsTableview.dataSource = self
    }
}
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        guard
            let searchCell = cell as? ProductTableViewCell
        else { return cell }
        if let product = presenter.products?[indexPath.row]{
            searchCell.setProduct(product)
        }
        return searchCell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastCell = indexPath.row == presenter.products?.count ?? 0 - 1
        // Only continue when there is no previous load next page request in order
        // to not get possible duplicate results.
        guard isLastCell, presenter.isLoadingNextPage == false else { return }
        if let searchBarText = searchBar.text{
            presenter.search(searchBarText)
        }
    }
    
}
extension ProductsViewController: ProductsViewProtocol{
    func showProducts() {
        DispatchQueue.main.async {
            self.productsTableview.reloadData()
        }
    }
    
    
}
extension ProductsViewController: UISearchBarDelegate {
    
    func endSearchTask(text: String) {
        let dispatchTime: DispatchTime = DispatchTime.now() + 0.5
        self.searchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            // Send new request for search based on the text
            self?.presenter.search(text)
        }
        self.searchTask = task
        
        DispatchQueue.global().asyncAfter(deadline: dispatchTime, execute: task)
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchBarText = searchBar.text
        guard
            let text = searchBarText, !text.isEmpty
        else {
//            self.modelController.resetData()
            self.searchTask?.cancel()
            return
        }
        
//        if modelController.data.isEmpty {
//            loader.startAnimating()
//        }
        endSearchTask(text: text)
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchResults.removeAll()
//    }

}
