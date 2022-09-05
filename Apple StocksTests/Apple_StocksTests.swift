//
//  Apple_StocksTests.swift
//  Apple StocksTests
//
//  Created by TheGIZzz on 24/8/2565 BE.
//

import XCTest
@testable import Apple_Stocks

class Apple_StocksTests: XCTestCase {
    
    func testCandleStickDataConversion() {
        let doubles: [Double] = Array(repeating: 12.2, count: 10)
        var timestamps: [TimeInterval] = []
        for x in 0..<10 {
            let interval = Date().addingTimeInterval(3600 * TimeInterval(x)).timeIntervalSince1970
            timestamps.append(interval)
        }
        timestamps.shuffle()

        let marketData = MarketDataResponse(
            open: doubles,
            close: doubles,
            low: doubles,
            high: doubles,
            status: "success",
            timeStamps: timestamps
        )

        let candleSticks = marketData.candleSticks

        XCTAssertEqual(candleSticks.count, marketData.open.count)
        XCTAssertEqual(candleSticks.count, marketData.close.count)
        XCTAssertEqual(candleSticks.count, marketData.high.count)
        XCTAssertEqual(candleSticks.count, marketData.low.count)
        XCTAssertEqual(candleSticks.count, marketData.timeStamps.count)
        
        let dates = candleSticks.map { $0.date }
        for index in 0..<dates.count-1 {
            let current = dates[index]
            let next = dates[index+1]
            XCTAssertTrue(current > next, "\(current) date should be greater than \(next) date")
        }
    }
}
