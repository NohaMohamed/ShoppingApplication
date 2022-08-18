//
//  RequestProtocol.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 18/08/2022.
//

import Foundation
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

typealias Parameters = [String: String]
typealias HTTPHeaders = [String: String]

protocol RequestProtocol {
    var baseURL: String { get }
    var endPoint: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}
public protocol Model: Codable {}
