//
//  APICaller.swift
//  app-News
//
//  Created by Jean Ricardo Cesca on 05/09/22.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    struct Constants {
        static let topHealinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b4e1c464cdcf4d8a8f57a401f7c0bf8f")
        static let searchUrlString = "https://newsapi.org/v2/everything?apiKey=b4e1c464cdcf4d8a8f57a401f7c0bf8f&q="
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Articles], Error>) -> Void) {
        
        guard let url = Constants.topHealinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.articles))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func search(with query: String, completion: @escaping (Result<[Articles], Error>) -> Void) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                
        let urlString = Constants.searchUrlString + query
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.articles))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


