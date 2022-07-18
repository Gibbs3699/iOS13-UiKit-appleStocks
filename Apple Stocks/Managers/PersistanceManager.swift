//
//  PersistanceManager.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 18/7/2565 BE.
//

import Foundation

final class PersistanceManager {
    
    static let shared = PersistanceManager()
    
    private let userDefault: UserDefaults = .standard
    
    private struct Constant {

    }
    
    private init() {}
    
    // MARK: - Public
    
    public var watchList: [String] {
        return []
    }
    
    public func addToWatchList() {
        
    }
    
    public func reMoveFromWatchList() {
        
    }
    
    // MARK: - Private
    
    private var hasOnBoarded: Bool {
        return false
    }
}
