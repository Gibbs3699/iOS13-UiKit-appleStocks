//
//  Extension.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 19/7/2565 BE.
//

import Foundation
import UIKit

// MARK: - Framing

extension UIView {
    /// Width of view
    var width: CGFloat {
        frame.size.width
    }

    /// Height of view
    var height: CGFloat {
        frame.size.height
    }

    /// Left edge of view
    var left: CGFloat {
        frame.origin.x
    }

    /// Right edge of view
    var right: CGFloat {
        left + width
    }

    /// Top edge of view
    var top: CGFloat {
        frame.origin.y
    }

    /// Bottom edge of view
    var bottom: CGFloat {
        top + height
    }
}

// MARK: - Add Subview

extension UIView {
    /// Adds multiple subviews
    /// - Parameter views: Collection of subviews
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

// MARK: - DateFormatter

extension DateFormatter {
    static let newsDateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    static let prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

extension String {
    /// Create string from time interval
    /// - Parameter timeInterval: Timeinterval sinec 1970
    /// - Returns: Formatted string
    static func string(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatter.prettyDateFormatter.string(from: date)
    }
}

// ImageView

extension UIImageView {
    /// Sets image from remote url
    /// - Parameter url: URL to fetch from
    func setImage(with url: URL?) {
        guard let url = url else {
            return
        }

        DispatchQueue.global(qos: .userInteractive).async {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}
