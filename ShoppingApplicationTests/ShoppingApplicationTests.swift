//
//  ShoppingApplicationTests.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 18/08/2022.
//

import XCTest
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
        sut?.search("1")
        XCTAssertEqual(sut?.products?.count, 24)
    }
}
