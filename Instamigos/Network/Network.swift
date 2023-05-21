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
    
    func fetchRequest(urlPath: String, requestBody: CreateUserRequest?, authentication: AuthenticationType?, httpMethod: HTTPMethods, contentType: ContentTypes?, completion: ((_ responseData: SessionUserResponse) -> Void)?) {
        
        let session = URLSession.shared
        
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
            if let error = error {
                print("Erro ao buscar dados: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("STATUS CODE: \(response.statusCode) \(response.url?.absoluteString ?? "")")
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(SessionUserResponse.self, from: data)
                completion?(responseData)
                
                
            } catch {
                print("Erro ao decodificar os dados JSON: \(error)")
            }
        }
        
        task.resume()
    }
}

