//
//  SearchService.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation
import NetworkingLayer

protocol SearchServiceProtocol {
    var apiClient: APICleintProtocol { get set }
    func fetchSearchResult(text: String,page: Int,compeletion : @escaping (Result<SearchResult, CustomNetworkError>) -> Void)
}
struct SearchService{
    
    // MARK: - Dependencies
    
    var apiClient: APICleintProtocol = APICleint.shared

}
// MARK: - Extensions

extension SearchService: SearchServiceProtocol {
    
    // MARK: - Functions
    func fetchSearchResult(text: String,page: Int, compeletion: @escaping (Result<SearchResult, CustomNetworkError>) -> Void) {
        apiClient.send(request: SearchRequest.search(query: text, page: page), compeletion: compeletion)
    }
}
