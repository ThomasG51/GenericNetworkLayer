//
//  Webservice.swift
//  GenericNetworkLayer
//
//  Created by Thomas George on 16/08/2022.
//

import Foundation

@MainActor
class Webservice {
    /**
     Generate a Bearer and store it into UserDefaults
     
     - throws: NetworkError
     */
    static func authenticate() async throws {
        // MARK: Bearer
        
        guard let bearer = try? await load(resource: Endpoint.getBearer()) else {
            throw NetworkError.generatingBearerFailed
        }
        
        guard bearer.setToUserDefaults() else {
            throw NetworkError.setBearerToUserDefaultsFailed
        }
    }
    
    /**
     Generic method to make a request to a Webservice
     
     - parameters:
        - resource: A resource containing all infos needed to make a request
     - throws: NetworkError
     - returns: Data received
     */
    static func load<T: Codable>(resource: Resource<T>) async throws -> T {
        // MARK: Request
        
        guard let url = resource.url else {
            throw NetworkError.wrongURL
        }
        
        var request = URLRequest(url: url)

        // MARK: Method
        
        switch resource.method {
        case .get:
            request.httpMethod = resource.method.name
        case .post(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        }
        
        // MARK: Configuration Header

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        if let headers = resource.headers {
            for (key, value) in headers {
                configuration.httpAdditionalHeaders?.updateValue(value, forKey: key)
                
                // MARK: Check Bearer
                
                if key == "Authorization" {
                    guard let bearer = Bearer.getFromUserDefaults() else {
                        throw NetworkError.noBearerFound
                    }
                    
                    guard bearer.expires_in < Date().timeIntervalSince1970 else {
                        throw NetworkError.bearerExpired
                    }
                }
            }
        }
        
        // MARK: Session

        let session = URLSession(configuration: configuration)
        let (data, response) = try await session.data(for: request)
        
        // MARK: Response
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode < 400 else {
            throw NetworkError.httpCodeError(httpResponse.statusCode)
        }
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingFailed
        }
        
        return result
    }
}
