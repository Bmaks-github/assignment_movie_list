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
    
    func getData(with path: String, params: [URLQueryItem]?, completion: @escaping ResultHandler<Data>) {
        guard let url = createUrl(path: path, params: params) else { return completion(.failure(NSError.commonError))}
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return completion(.failure(NSError.commonError))
            }
            
            completion(.success(data))
        }

        task.resume()
    }
    
    private func createUrl(path: String, params: [URLQueryItem]?) -> URL? {
        var urlCompsCopy = urlComps
        var queryItemsCopy = queryItems
        
        queryItemsCopy.append(contentsOf: params ?? [])
        urlCompsCopy?.path += path
        urlCompsCopy?.queryItems = queryItemsCopy
        
        return urlCompsCopy?.url
    }
}
