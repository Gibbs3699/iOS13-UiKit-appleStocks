//
//  NewsStory.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 25/7/2565 BE.
//

import Foundation

struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let id: Int
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}
