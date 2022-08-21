//
//  SearchPresenterMock.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
@testable import ShoppingApplication
class SearchPresenterMock: SearchPresenterToViewProtocol{
  
    var loadingNextPage: Bool = false
    var isloading: Bool = false
    var isSearchCalled = false
    var pageCount = 0
    
    func loadNextPage(text: String) {
        loadingNextPage = true
        search(text)
    }
    
    func getProducts() -> [SearchResultUIModel] {
        return [SearchResponseMock.getUIProduct()]
    }
    func resetProducts() {
        pageCount = 1
    }
    func search(_ text: String) {
        isSearchCalled = true
        return
    }
    
}
