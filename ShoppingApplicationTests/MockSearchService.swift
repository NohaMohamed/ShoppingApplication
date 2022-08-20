//
//  MockSearchService.swift
//  TrackFinderTests
//
//  Created by Niels Hoogendoorn on 23/06/2020.
//  Copyright © 2020 Nihoo. All rights reserved.
//

import Foundation
@testable import ShoppingApplication
protocol MockAPIClientProtocol : APICleintProtocol {
    var data: Data? {get set}
    var error: CustomNetworkError? {get set}
}
class MockAPIClient: MockAPIClientProtocol {
    var data: Data?
    
    var error: CustomNetworkError?
    
    func configure(data: Data?, error: CustomNetworkError?){
        self.data = data
        self.error = error
    }
    
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType: Codable {
        if let data = data , let decodedData = try? JSONDecoder().decode(ResponsType.self, from: data) {
            compeletion(.success(decodedData))
        }else if let error = error {
            compeletion(.failure(error))
        }else{
            compeletion(.failure(.generic))
        }
    }
}
