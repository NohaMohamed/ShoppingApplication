//
//  APICleint.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import Foundation

class APICleint {
    
    static let shared = APICleint()
    
    private init() {}
}

extension APICleint: APICleintProtocol {
    
    func send<ResponsType>(request: RequestProtocol, compeletion: @escaping (Result<ResponsType, CustomNetworkError>) -> Void) where ResponsType : Codable {
//        Session.default.request(request).validate().responseObject(compeletion: compeletion)
            // Set the task, but don't resume it yet. This will happen in the
            // operation queue.
            
            let session = URLSession.shared
        let urlrequest = session.request(request)
        let task = session.dataTask(with: urlrequest, completionHandler: { (data, response, _) in
                // Spotify Requests will use the cache to quickly retrieve previous requests.
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
              return
            }
            guard let data = data else {
              return
            }
            if let result = String(data: data, encoding: .utf8) {
              print(result)
            }
            })
        task.resume()
    }
}
extension URLRequest {
    mutating func addQuery(query: [URLQueryItem]) {
        guard let url = self.url else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = query
        let body = urlComponents?.query?.data(using: .utf8)
        switch self.httpMethod {
        case HTTPMethod.post.rawValue:
            self.httpBody = body
        case HTTPMethod.get.rawValue:
            self.url = urlComponents?.url
        default:
            break
        }
    }
}

struct RequestMapper {
    
    var request: RequestProtocol
    
    init(_ request: RequestProtocol) {
        self.request = request
    }
    
    func asURLRequest() throws -> URLRequest {
        if let url = URL(string: request.baseURL+request.endPoint) {
            var urlRequest = URLRequest(url: url)
            let method = request.method
            urlRequest.httpMethod = method.rawValue
            
            if method == .get {
                urlRequest.allHTTPHeaderFields = request.headers
                urlRequest.httpMethod = method.rawValue
                let queryItems = request.parameters?.map {
                     URLQueryItem(name: $0, value: $1)
                }
                if let items = queryItems {
                    urlRequest.addQuery(query: items)}
                return urlRequest
            }

            return urlRequest
        }
        throw CustomNetworkError.canNotMapRequest
    }
}

extension URLSession {
    func request(_ request: RequestProtocol) -> URLRequest {
        let alamofireRequestMapper = RequestMapper(request)
        let mappedRequest = try! alamofireRequestMapper.asURLRequest()
        return mappedRequest
    }
}
