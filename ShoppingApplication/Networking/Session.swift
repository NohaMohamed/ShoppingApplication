//
//  Session.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//

import Foundation

extension URLSession {
    func request(_ request: RequestProtocol) -> URLRequest {
        let requestMapper = RequestMapper(request)
        let mappedRequest = try! requestMapper.asURLRequest()
        return mappedRequest
    }
}
