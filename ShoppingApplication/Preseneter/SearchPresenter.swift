//
//  ProductsPresenter.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation

protocol SearchPresenterToViewProtocol {
    var loadingNextPage: Bool {get set}
    func search(_ text: String)
    func loadNextPage(text: String)
    func getProducts() -> [SearchResultUIModel]
    func resetProducts()
}
final class SearchPresenter {
    
    //MARK: Dependencies
    
    weak var view: SearchViewProtocol?
    var service : SearchServiceProtocol?
    
    //MARK: Properties
    
    var totalPages = 1
    var pageToLoad = 1
    var loadingNextPage: Bool = false
    private var products = [SearchResultUIModel]()
    var errorMessage: String?
    
    init(service: SearchServiceProtocol) {
        self.service = service
    }
    func mapUIModel(product: SearchResult.Product) -> SearchResultUIModel{
        return SearchResultUIModel(productName: product.productName ?? "", salesPrice: "Price : \(product.salesPriceIncVat)", productImageUrl: product.productImage)
    }
}
extension SearchPresenter: SearchPresenterToViewProtocol{
    
    func search(_ text: String) {
        showLoading()
        service?.fetchSearchResult(text: text, page: pageToLoad) { [weak self] result in
            self?.hideLoading()
            self?.loadingNextPage = false
            switch result{
            case .success(let model):
                guard let self = self, let items = model.products , items.count > 0 else {
                    return
                }
                self.products.append(contentsOf: items.map(self.mapUIModel(product:)))
                self.pageToLoad = model.currentPage + 1
                self.totalPages = model.pageCount
                self.view?.didRecieveProducts()
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.view?.didRecieveError(error.localizedDescription)
                break
            }
        }
    }
    func loadNextPage(text: String){
        guard pageToLoad <= totalPages else {
            return
        }
        loadingNextPage = true
        search(text)
    }
    func getProducts() -> [SearchResultUIModel] {
        return products
    }
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showLoading()
        }
        
    }
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
        }
    }
    func resetProducts() {
        products = []
        pageToLoad = 1
        self.view?.didRecieveProducts()
    }
}
