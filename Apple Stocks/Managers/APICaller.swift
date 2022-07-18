//
//  APICaller.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 18/7/2565 BE.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constant {
        let apiKey = ""
        let sandboxApiKey = ""
        let baseURL = ""
    }
    
    private init() {
        
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    private enum EndPoint: String {
        case search
    }
    
    private enum APIError: Error {
        case invalidURL
        case noDataReturned
    }
    
    private func url(for endPoint: EndPoint, queryParams: [String: String] = [:]) -> URL? {
        
        return nil
    }
    
    private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch  {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
}
