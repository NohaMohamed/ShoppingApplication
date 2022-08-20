//
//  SearchResponseMock.swift
//  ShoppingApplicationTests
//
//  Created by Noha Mohamed on 20/08/2022.
//

import Foundation
import Networking
@testable import ShoppingApplication
class SearchResponseMock {
    static func getSearchResponse() -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: "success_response", withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    static func getWrongResponse() -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: "wrong_response", withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
}

