//
//  SearchRequest.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation
//https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search?query=apple&page=1
enum SearchRequest: RequestProtocol {
    
    case search(query: String, page:Int)
    
    var endPoint: String {
        switch self{
        case .search:
            return "ios-assignment/search"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .search:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    var parameters: Parameters? {
        switch self{
        case  .search(let query,let page):
            return [Keys.query.rawValue : query,
                    Keys.page.rawValue : "\(page)"
            ]
        }
    }
    enum Keys: String {
        case query
        case page
    }
}
