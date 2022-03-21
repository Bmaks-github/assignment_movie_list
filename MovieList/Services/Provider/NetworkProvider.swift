//
//  NetworkProvider.swift
//  MovieList
//
//  Created by Maksym Bura on 10.03.2022.
//

import Foundation

final class NetworkProvider {
    
    private var urlComps: URLComponents?
    private var queryItems = [URLQueryItem]()
    
    init(path: String) {
        urlComps = URLComponents(string: Constants.Domain.baseUrl + path)
        queryItems.append(URLQueryItem(name: "api_key", value: Constants.Domain.apiKey))
    }
    
    func getData<T: Decodable>(with path: String, params: Dictionary<String, String>?, completion: @escaping ResultHandler<T>) {
        guard let url = createUrl(path: path, params: params) else { return completion(.failure(NSError.commonError))}
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return completion(.failure(NSError.commonError))
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let jsonError as NSError {
                completion(.failure(jsonError))
            }
        }

        task.resume()
    }
    
    private func createUrl(path: String, params: Dictionary<String, String>?) -> URL? {
        var urlCompsCopy = urlComps
        var queryItemsCopy = queryItems
        
        if let params = params {
            params.forEach { (key, value) in
                queryItemsCopy.append(.init(name: key, value: value))
            }
        }
        
        urlCompsCopy?.path += path
        urlCompsCopy?.queryItems = queryItemsCopy
        
        return urlCompsCopy?.url
    }
}
