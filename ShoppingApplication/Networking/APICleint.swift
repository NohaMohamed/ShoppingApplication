//
//  APICleint.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import Foundation

protocol APICleintProtocol {
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType: Codable
}

class APICleint {
    
    static let shared = APICleint()
    
    private init() {}
}

extension APICleint: APICleintProtocol {
    
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType : Codable {
        
        let session = URLSession.shared
        let urlrequest = session.request(request)
        let task = session.dataTask(with: urlrequest, completionHandler: { (data, response, _) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                compeletion(Result.failure(.generic))
                return
            }
            guard let data = data else {
                compeletion(Result.failure(.generic))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(ResponsType.self, from: data)
                compeletion(Result.success(decodedData))
            }
            catch let error {
                print("Failed to decode JSON\(error)")
                compeletion(Result.failure(.canNotDecodeObject))
            }
            if let result = String(data: data, encoding: .utf8) {
                print(result)
            }
        })
        task.resume()
    }
}
