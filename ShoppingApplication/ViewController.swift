//
//  ViewController.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 18/08/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let com : (Result<SearchResult, CustomNetworkError>) -> Void = { result in
            
        }
        APICleint.shared.send(request: SearchRequest.search,compeletion: com)
    }


}
//https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search?query=apple&page=1
enum SearchRequest: RequestProtocol {
    
    case search
    
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
        case  .search:
            return ["query" : "apple",
             "page" : "1"
            ]
        }
    }
}
extension RequestProtocol {
    var baseURL: String {
        return "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/"
    }
}
