//
//  StockChartView.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 2/8/2565 BE.
//

import UIKit

class StockChartView: UIView {

    struct ViewModel {
        let data: [Double]
        let showLegend: Bool
        let showAxis: Bool
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        
    }

}
