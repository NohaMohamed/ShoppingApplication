//
//  SearchResponseMock.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
@testable import ShoppingApplication
class SearchResponseMock {
    static func getSearchResponse() -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: "response", withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
}

