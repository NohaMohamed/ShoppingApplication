//
//	Product.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

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
	let salesPriceIncVat : Int?


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
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uSPs = try values.decodeIfPresent([String].self, forKey: .uSPs)
		availabilityState = try values.decodeIfPresent(Int.self, forKey: .availabilityState)
		coolbluesChoiceInformationTitle = try values.decodeIfPresent(String.self, forKey: .coolbluesChoiceInformationTitle)
		nextDayDelivery = try values.decodeIfPresent(Bool.self, forKey: .nextDayDelivery)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		promoIcon = try PromoIcon(from: decoder)
		reviewInformation = try ReviewInformation(from: decoder)
		salesPriceIncVat = try values.decodeIfPresent(Int.self, forKey: .salesPriceIncVat)
	}


}
