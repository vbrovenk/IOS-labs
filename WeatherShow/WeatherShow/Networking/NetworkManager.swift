//
//  NetworkManager.swift
//  WeatherShow
//
//  Created by Vadim on 13.04.2022.
//

import Foundation

final class NetworkManager<T: Codable> {
    
    // completionHandler - returns data
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        // creating of session request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // in case if we get error
            guard error == nil else {
                print(String(describing: error))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            // code 200 shows we get OK response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // in case of fail data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
            
        }.resume()
    }
}

// list of possible errors
enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}
