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
        guard let url = Bundle(for: Self.self).url(forResource: "success_response", withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    static func getWrongResponse() -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: "wrong_response", withExtension: "json") else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    static func getProduct() -> SearchResult.Product{
        return  SearchResult.Product(uSPs: nil, availabilityState: nil, coolbluesChoiceInformationTitle: nil, nextDayDelivery: nil, productId: 123, productImage: nil, productName: "iphone", promoIcon: nil, reviewInformation: nil, salesPriceIncVat: 25.0)
    }
    static func getUIProduct() -> ProductUIModel{
        return  ProductUIModel(productName: "iphone", productPrice: "Price: 25.0", productImage: nil)
    }
}

