//
//  ProductsService.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation
protocol ProductsServiceProtocol {
    func fetchSearchResult(text: String,page: Int,compeletion : @escaping (Result<SearchResult, CustomNetworkError>) -> Void)
}
struct ProductsService{
    
    // MARK: - Dependencies
    
    var apiClient: APICleintProtocol

}
// MARK: - Extensions

extension ProductsService: ProductsServiceProtocol {
    
    // MARK: - Functions
    func fetchSearchResult(text: String,page: Int, compeletion: @escaping (Result<SearchResult, CustomNetworkError>) -> Void) {
        apiClient.send(request: SearchRequest.search(query: text, page: page), compeletion: compeletion)
    }
}
