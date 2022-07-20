//
//  APICaller.swift
//  Apple Stocks
//
//  Created by TheGIZzz on 18/7/2565 BE.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKey = "cbbsfe2ad3ibhoa2ac2g"
        static let sandboxApiKey = "sandbox_cbbsfe2ad3ibhoa2ac30"
        static let baseURL = "https://finnhub.io/api/v1/"
    }
    
    private init() {}
    
    // MARK: - Public
    
    public func search(query: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        request(url: url(for: .search, queryParams: ["q":safeQuery]), expecting: SearchResponse.self, completion: completion)
    }
    
    
    // MARK: - Private
    
    private enum EndPoint: String {
        case search
    }
    
    private enum APIError: Error {
        case invalidURL
        case noDataReturned
    }
    
    private func url(for endPoint: EndPoint, queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseURL + endPoint.rawValue
        
        var queryItems = [URLQueryItem]()
        
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        urlString += "?" + queryItems.map {"\($0.name)=\($0.value ?? "")"}.joined(separator: "&")
        
        print("\n\(urlString)\n")
        
        return URL(string: urlString)
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