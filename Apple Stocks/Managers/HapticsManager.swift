//
//  HapticsManager.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 18/7/2565 BE.
//

import Foundation
import UIKit

final class HapticsManager {
    
    static let shared = HapticsManager()
    
    private init() {}
    
    // MARK: - Public
    
    public func vibrateFromSelection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }

    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
