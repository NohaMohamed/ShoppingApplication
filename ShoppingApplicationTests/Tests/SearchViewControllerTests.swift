//
//  SearchViewControllerTests.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import XCTest
@testable import ShoppingApplication

class SearchViewControllerTests: XCTestCase {
    lazy var presenter: SearchPresenterMock? = SearchPresenterMock()
    lazy var sut : SearchViewController? = {
        let vc = SearchViewController()
        if let presenter = presenter {
            vc.presenter = presenter
        }
        return vc
    }()
    
    override func tearDown(){
        super.tearDown()
        presenter = nil
        sut = nil
    }
    func test_NumberOfRowsInSection() throws {
        // Given
        sut?.loadViewIfNeeded()
        // When
        guard let sut = sut else {
            return
        }
        let rows = sut.tableView(sut.productsTableview , numberOfRowsInSection: 1)
        // Then
        XCTAssertEqual(rows, 1)
    }

    func test_CellForRow_rightData() {
        // Given
        sut?.loadViewIfNeeded()
        // When
        guard let sut = sut else {
            return
        }
        let cell = sut.tableView(sut.productsTableview, cellForRowAt: IndexPath(row: 0, section: 0)) as? ProductTableViewCell
        // Then
        XCTAssertEqual(cell?.titleLabel.text, "iphone")
        XCTAssertNotNil(cell?.priceLabel.text?.contains("25.0"))
    }
    func test_Search() {
        // Given
        sut?.loadViewIfNeeded()
        // When
        sut?.searchController.searchBar.text = "apple"
        // Then
        guard let sut = sut , let presenter =  presenter else {
            return
        }
        DispatchQueue.global().asyncAfter(deadline: sut.dispatchTime ) {
            XCTAssertTrue(presenter.isSearchCalled)
        }
    }
}
