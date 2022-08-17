//
//  NetworkConfig.swift
//  GenericNetworkLayer
//
//  Created by Thomas George on 16/08/2022.
//

// MARK: - Error

enum NetworkError: Error {
    case wrongURL
    case invalidResponse
    case httpCodeError(Int)
    case decodingFailed
    case noBearerFound
    case bearerExpired
    case generatingBearerFailed
    case setBearerToUserDefaultsFailed
    case getBearerFromUserDefaultsFailed
}

// MARK: - HttpMethod

enum HttpMethod {
    case get
    case post(Data?)

    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

// MARK: - Bearer

struct Bearer: Codable {
    let access_token: String
    let expires_in: Double
    let token_type: String
}

extension Bearer {
    func setToUserDefaults() -> Bool {
        do {
            let encodedData = try JSONEncoder().encode(self)
            UserDefaults.standard.set(encodedData, forKey: "bearer")
            return true
        } catch {
            return false
        }
    }

    static func getFromUserDefaults() -> Bearer? {
        guard let data = UserDefaults.standard.object(forKey: "bearer") as? Data else {
            return nil
        }

        do {
            let bearer = try JSONDecoder().decode(Bearer.self, from: data)
            return bearer
        } catch {
            return nil
        }
    }
}

// MARK: - Resource

struct Resource<T: Codable> {
    let url: URL?
    var method: HttpMethod
    var headers: [String: String]? = nil
}
