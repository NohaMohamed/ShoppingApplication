//
//  SearchViewController+.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 21/08/2022.
//

import Foundation
import UIKit

extension SearchViewController{
    func setSearchBarView() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func showError(message: String){
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localization.string(for: .done), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        guard
            let searchCell = cell as? ProductTableViewCell
        else { return cell }
        searchCell.setProduct(presenter.getProducts()[indexPath.row])
        return searchCell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastCell = indexPath.row == presenter.getProducts().count  - 1
        // Only continue when there is no previous load next page request in order
        // to not get possible duplicate results.
        guard isLastCell, presenter.loadingNextPage == false else { return }
        if let searchBarText = searchController.searchBar.text {
            presenter.loadNextPage(text: searchBarText)
        }
    }
    
}
