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

