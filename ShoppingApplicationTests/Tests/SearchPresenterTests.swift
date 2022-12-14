//
//  ShoppingApplicationTests.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 18/08/2022.
//

import XCTest
import NetworkingLayer
@testable import ShoppingApplication

class SearchPresenterTests: XCTestCase {
    var mockSearchService : SearchServiceMock? = SearchServiceMock()
    lazy var sut : SearchPresenter? = {
        guard let service = mockSearchService else{
            return nil
        }
        let presenter = SearchPresenter(service: service)
        return presenter
    }()
    
    override func tearDown(){
        super.tearDown()
        mockSearchService = nil
        sut = nil
    }
    func test_searchData_isNotEmpty(){
        // Given
        let searchResult = SearchResponseMock.getSearchResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        // When
        sut?.search("apple")
        // Then
        XCTAssertEqual(sut?.getProducts().count, 24)
    }
    func test_searchQuery_data_isEmpty() {
        // Given
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        // When
        sut?.search("apple")
        // Then
        XCTAssertEqual(sut?.getProducts().count, 0)
    }
    func test_searchQuery_nextPageIncremented() {
        // Given
        let searchResult = SearchResponseMock.getSearchResponse()
        mockSearchService?.configure(data: searchResult, error: nil)
        // When
        sut?.search("apple")
        // Then
        XCTAssertEqual(sut?.pageToLoad, 2)
    }
    func test_search_nextPageInCaseFailure(){
        // Given
        mockSearchService?.configure(data: nil, error: CustomNetworkError.generic)
        // When
        sut?.search("apple")
        // Then
        XCTAssertEqual(sut?.pageToLoad, 1)
    }
    
    func test_search_decodeFailure(){
        // Given
        let searchResult = SearchResponseMock.getWrongResponse()
        // When
        mockSearchService?.configure(data: searchResult, error: nil)
        sut?.search("apple")
        // Then
        XCTAssertEqual(sut?.errorMessage, CustomNetworkError.canNotDecodeObject.localizedDescription)
    }
    func test_map(){
        // Given
        let apiModel = SearchResponseMock.getProduct()
        // When
        let uiModel = sut?.mapUIModel(product: apiModel)
        // Then
        XCTAssertEqual(uiModel?.productName, apiModel.productName)
        XCTAssertNotNil(uiModel?.productPrice.contains("\(apiModel.salesPriceIncVat)"))
        }
    }
