//
//  ShoppingApplicationTests.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 18/08/2022.
//

import XCTest
import Networking
@testable import ShoppingApplication

class SearchModelControllerTests: XCTestCase {
    var mockSearchService : ProductsServiceSpy? = ProductsServiceSpy()
    lazy var sut : ProductsPresenter? = {
        guard let service = mockSearchService else{
            return nil
        }
        let presenter = ProductsPresenter(service: service)
        return presenter
    }()
    override func tearDown(){
        super.tearDown()
        mockSearchService = nil
    }
    func test_searchData_isNotEmpty(){
        let searchResult = SearchResponseMock.getSearchResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        sut?.search("apple")
        XCTAssertEqual(sut?.products?.count, 24)
    }
    func test_searchQuery_data_isEmpty() {
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        sut?.search("apple")
        XCTAssertNil(sut?.products)
    }
    func test_searchQuery_nextPageIncremented() {
        let searchResult = SearchResponseMock.getSearchResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        sut?.search("apple")
        XCTAssertEqual(sut?.pageToLoad, 2)
    }
    func test_search_nextPageInCaseFailure(){
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        sut?.search("apple")
        XCTAssertEqual(sut?.pageToLoad, 1)
    }
    
    func test_search_decodeFailure(){
        let searchResult = SearchResponseMock.getWrongResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        sut?.search("apple")
        XCTAssertEqual(sut?.error?.localizedDescription, CustomNetworkError.canNotDecodeObject.localizedDescription)
    }
    
}
