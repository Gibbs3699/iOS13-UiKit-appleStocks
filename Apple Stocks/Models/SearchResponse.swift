//
//  SearchResponse.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 20/7/2565 BE.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}


