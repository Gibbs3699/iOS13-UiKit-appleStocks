//
//  SearchResultsTableViewCell.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 19/7/2565 BE.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    static let identifier = "SearchResultsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
