//
//	ReviewInformation.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ReviewInformation : Codable {

	let reviewSummary : ReviewSummary?
	let reviews : [String]?


	enum CodingKeys: String, CodingKey {
		case reviewSummary
		case reviews = "reviews"
	}


}
