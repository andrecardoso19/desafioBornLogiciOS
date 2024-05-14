//
//  HomeService.swift
//  DesafioBornlogic
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews(completion: @escaping (Result<[NewsArcticle], NewsArticleError>) -> Void)
}

final class NewsService: NewsServiceProtocol {
    let apiKey = "c056882bea044051aa752382b23fedfc"
    
    internal func fetchNews(completion: @escaping (Result<[NewsArcticle], NewsArticleError>) -> Void) {
        let apiUrl = "https://newsapi.org/v2/everything?q=bitcoin&pageSize=20&apiKey=\(apiKey)"
        
        guard let api = URL(string: apiUrl) else {
            return completion(.failure(.urlError))
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            if let error = error {
                return completion(.failure(.decodeError(error: error)))
            }
            guard let jsonData = data else {
                return completion(.failure(.genericError))
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(NewsArticleResponse.self, from: jsonData)
                print(decoded)
                
                completion(.success(decoded.articles))
            } catch _ {
                completion(.failure(.dataError))
            }
        }
        
        task.resume()
    }
}

enum NewsArticleError: Error {
    case dataError
    case urlError
    case decodeError(error: Error)
    case genericError
    
    var message: String {
        let message: String
        
        switch self {
        case .dataError:
            message = "There was an error with the data received."
        case .urlError:
            message = "There was an URL error."
        case .decodeError(let error):
            message = error.localizedDescription
        case .genericError:
            message = "There was an unknown error"
        }
        
        return message
    }
}
