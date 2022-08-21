//
//  ProductTableViewCell.swift
//  ShoppingApplication
//
//  Created by Noha Mohamed on 19/08/2022.
//
import Foundation

struct SearchResult : Codable {
    
    let products : [Product]?
    let currentPage , pageSize , totalResults ,pageCount : Int

    enum CodingKeys: String, CodingKey {
        case products = "products"
        case currentPage , totalResults , pageCount , pageSize
        
    }
    struct Product : Codable {
        
        let uSPs : [String]?
        let availabilityState : Int?
        let coolbluesChoiceInformationTitle : String?
        let nextDayDelivery : Bool?
        let productId : Int?
        let productImage : String?
        let productName : String?
        let promoIcon : PromoIcon?
        let reviewInformation : ReviewInformation?
        let salesPriceIncVat : Float
        
        
        enum CodingKeys: String, CodingKey {
            case uSPs = "USPs"
            case availabilityState = "availabilityState"
            case coolbluesChoiceInformationTitle = "coolbluesChoiceInformationTitle"
            case nextDayDelivery = "nextDayDelivery"
            case productId = "productId"
            case productImage = "productImage"
            case productName = "productName"
            case promoIcon
            case reviewInformation
            case salesPriceIncVat = "salesPriceIncVat"
        }
    }
    struct PromoIcon : Codable {
        
        let text : String?
        let type : String?
        
        enum CodingKeys: String, CodingKey {
            case text = "text"
            case type = "type"
        }
    }
    struct ReviewSummary : Codable {
        
        let reviewAverage : Float?
        let reviewCount : Int?
        
        
        enum CodingKeys: String, CodingKey {
            case reviewAverage = "reviewAverage"
            case reviewCount = "reviewCount"
        }
    }
    struct ReviewInformation : Codable {
        
        let reviewSummary : ReviewSummary?
        let reviews : [String]?
        
        
        enum CodingKeys: String, CodingKey {
            case reviewSummary
            case reviews = "reviews"
        }
    }
}
