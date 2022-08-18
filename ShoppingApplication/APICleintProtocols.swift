//
//  NetworkClient.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import Foundation



protocol APICleintProtocol {
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType: Codable
}
