//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct SearchResult : Codable {

	let products : [Product]?


	enum CodingKeys: String, CodingKey {
		case products = "products"
	}


}
