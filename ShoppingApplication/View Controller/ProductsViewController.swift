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
    
    lazy var presenter =  ProductsPresenter(delegate: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            let text = searchBarText,
            !text.isEmpty
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
