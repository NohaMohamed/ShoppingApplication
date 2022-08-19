//
//  ProductsPresenter.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation
protocol ProductsPresenterToViewProtocol {
    func search(_ text: String)
}
final class ProductsPresenter {
    weak var view: ProductsViewProtocol?
    lazy var service = ProductsService(apiClient: APICleint.shared)
    var products: [SearchResult.Product]?
    
    init(delegate: ProductsViewProtocol) {
        self.view = delegate
    }
}
extension ProductsPresenter: ProductsPresenterToViewProtocol{
    func search(_ text: String) {
        service.fetchSearchResult(text: text, page: 1) { [weak self] result in
            switch result{
                case .success(let model):
                guard let items = model.products , items.count > 0 else {
                    return
                }
                self?.products = items
                self?.view?.showProducts()
                break
                case .failure(let error):
                break
            }
        }
    }
}
