//
//	ReviewSummary.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ReviewSummary : Codable {

	let reviewAverage : Float?
	let reviewCount : Int?


	enum CodingKeys: String, CodingKey {
		case reviewAverage = "reviewAverage"
		case reviewCount = "reviewCount"
	}
}
