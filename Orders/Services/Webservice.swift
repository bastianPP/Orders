		//
//  Webservice.swift
//  Orders
//
//  Created by Pedro Paramo on 1/29/20.
//  Copyright © 2020 Pedro Paramo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        print("URL: ", resource.url)
        print("body: ", resource.httpMethod.rawValue)
        var request = URLRequest(url: resource.url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let data = data else {
                completion(.failure(.domainError))
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Regreso del servicio")
                print(String(data: data, encoding: .utf8))
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
