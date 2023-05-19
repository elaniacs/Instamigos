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

class Network {
    
    func fetchRequest(urlPath: String, requestBody: CreateUserRequest? = nil, authentication: BasicAuthenticationRequest? = nil) {
        
        
        let session = URLSession.shared
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 8080
        urlComponents.path = urlPath
        
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post.rawValue
        
        if let authenticationData = authentication?.loginString.data(using: String.Encoding.utf8) {
            let base64LoginString = authenticationData.base64EncodedString()
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let encoder = JSONEncoder()
            let httpBody = try encoder.encode(requestBody)
            request.httpBody = httpBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
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
                let responseData = try decoder.decode(CreateUserResponse.self, from: data)
                
            } catch {
                print("Erro ao decodificar os dados JSON: \(error)")
            }
        }
        
        task.resume()
    }
}
