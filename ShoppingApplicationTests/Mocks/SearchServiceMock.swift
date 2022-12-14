//
//  SearchServiceMock.swift
//  SearchServiceMock
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
import NetworkingLayer
@testable import ShoppingApplication

class SearchServiceMock: SearchServiceProtocol {
    var apiClient: APICleintProtocol = MockAPIClient()
    private lazy var mockAPI = apiClient as? MockAPIClient
    
    func configure(data: Data?, error: CustomNetworkError?){
        mockAPI?.configure(data: data, error: error)
    }
    func fetchSearchResult(text: String, page: Int, compeletion: @escaping (Result<SearchResult, CustomNetworkError>) -> Void) {
        mockAPI?.send(request: SearchRequest.search(query: text, page: 1), compeletion: compeletion)
    }
}
