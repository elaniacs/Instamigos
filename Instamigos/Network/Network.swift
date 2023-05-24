//
//  Network.swift
//  Instamigos
//
//  Created by Cáren Sousa on 19/05/23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ContentTypes {
    case json
    case textPlain(content: String)
    
    func rawValue() -> String{
        switch self {
        case .json:
            return "application/json"
        case .textPlain:
            return "text/plain"
        }
    }
}

enum AuthenticationType {
    case basic(loginString: String)
    case bearer(token: String)
    
    func authorizationHeaderValue() -> String {
        switch self {
        case .basic(let loginString):
            return "Basic \(loginString)"
        case .bearer(let token):
            return "Bearer \(token)"
        }
    }
}

class Network {
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchRequest<T: Decodable>(urlPath: String, requestBody: CreateUserRequest?, authentication: AuthenticationType?, httpMethod: HTTPMethods, contentType: ContentTypes?, completion: @escaping ((_ responseData: T?, _ statusCode: Int) -> Void)) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 8080
        urlComponents.path = urlPath
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
 
        if let authentication = authentication {
            let authorizationHeaderValue = authentication.authorizationHeaderValue()
            request.setValue(authorizationHeaderValue, forHTTPHeaderField: "Authorization")
        }
        
        do {
            var httpBody: Data?
            let encoder = JSONEncoder()
            
            switch contentType {
            case .json:
                httpBody = try encoder.encode(requestBody)
            case .textPlain(let content):
                httpBody = content.data(using: .utf8)
            default:
                break
            }
            
            request.httpBody = httpBody
            request.setValue(contentType?.rawValue(), forHTTPHeaderField: "Content-Type")
            
        } catch {
            print("Erro ao serializar os dados JSON: \(error)")
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else { return }
            print("STATUS CODE: \(response.statusCode) \(response.url?.absoluteString ?? "")")
            
            if let error = error {
                print("Erro ao buscar dados: \(error.localizedDescription)")
                completion(nil, response.statusCode)
                return
            }
            
            guard let data = data else {
                return
            }
            
            switch response.statusCode {
            case 200:
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(T.self, from: data)
                    completion(responseData, response.statusCode)
                } catch {
                    print("Erro ao decodificar os dados JSON: \(error)")
                }
            default:
                completion(nil, response.statusCode)
            }
        }
        
        task.resume()
    }
}

