//
//  ProductsPresenter.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation
import Networking
protocol ProductsPresenterToViewProtocol {
    func search(_ text: String)
}
final class ProductsPresenter {
    weak var view: ProductsViewProtocol?
    var totalPages = 1
    var pageToLoad = 1
    var isLoadingNextPage = false
    var service : ProductsServiceProtocol?
    var products: [SearchResult.Product]?
    var error: CustomNetworkError?
    
    init(service: ProductsServiceProtocol) {
        self.service = service
    }
}
extension ProductsPresenter: ProductsPresenterToViewProtocol{
    func search(_ text: String) {
        guard !isLoadingNextPage || pageToLoad < totalPages else {
            return
        }
        isLoadingNextPage = true
        service?.fetchSearchResult(text: text, page: pageToLoad) { [weak self] result in
            self?.isLoadingNextPage = false
            switch result{
                case .success(let model):
                guard let items = model.products , items.count > 0 else {
                    return
                }
                self?.products = items
                self?.pageToLoad = model.currentPage + 1
                self?.totalPages = model.pageCount
                self?.view?.showProducts()
                break
                case .failure(let error):
                self?.error = error
                break
            }
        }
    }
}
