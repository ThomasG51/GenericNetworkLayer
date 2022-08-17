//
//  Endpoint.swift
//  GenericNetworkLayer
//
//  Created by Thomas George on 16/08/2022.
//

import Foundation

struct Endpoint {
    // MARK: - Property

    static let bearer: Bearer? = Bearer.getFromUserDefaults()

    // MARK: - Function

    /**
     Differents examples with both method
     */

//    static let getExample() -> Resource<[Example]> {
//        // URL
//
//        let url = URL(string: "https://example.com/path")
//
//        // Headers?
//
//        let headers = [
//            "Authorization": "Bearer \(bearer?.access_token ?? "")",
//            "api_id": "azerty1"
//        ]
//
//        return Resource(url: url, method: .get, headers: headers)
//    }

//    static let getExampleQueryItems(id: String, page: String = "1") -> Resource<[Example]> {
//        // URL
//
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "example.com"
//        components.path = "/path/\(id)"
//
//        // QueryItems?
//
//        components.queryItems = [
//            URLQueryItem(name: "page", value: page)
//        ]
//
//        // Headers?
//
//        let headers = [
//            "Authorization": "Bearer \(bearer?.access_token ?? "")",
//            "api_id": "azerty1"
//        ]
//
//        return Resource(url: components.url, method: .get, headers: headers)
//    }

//    static let postExample() -> Resource<[Example]> {
//        // URL
//
//        let url = URL(string: "https://example.com/path")
//
//        // Headers?
//
//        let headers = [
//            "Authorization": "Bearer \(bearer?.access_token ?? "")",
//            "api_id": "azerty1"
//        ]
//
//        // Body?
//
//        let data = "body value".data(using: .utf8, allowLossyConversion: false)
//
//        return Resource(url: components.url, method: .post(data), headers: headers)
//    }
}
