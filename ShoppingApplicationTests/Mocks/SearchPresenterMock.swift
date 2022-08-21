//
//  SearchPresenterMock.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
@testable import ShoppingApplication
protocol SearchPresenterMockProtocol: SearchPresenterToViewProtocol{
    var isSearchCalled: Bool {set get}
}
class SearchPresenterMock: SearchPresenterMockProtocol{
    
    var loadingNextPage: Bool = false
    var isloading: Bool = false
    var isSearchCalled = false
    
    func loadNextPage(text: String) {
        search(text)
    }
    
    func showLoading() {
        isloading = true
    }
    
    func hideLoading() {
        isloading = false
    }
    
    func resetProducts() {
    }
    func getProducts() -> [SearchResultUIModel] {
        return [SearchResponseMock.getUIProduct()]
    }
    
    func search(_ text: String) {
        isSearchCalled = true
        return
    }
    
}
