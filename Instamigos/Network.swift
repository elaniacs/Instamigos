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
    
    func fetchRequest(requestBody: CreateUserRequest) {
        
        let session = URLSession.shared
        
        let url = URL(string: "http://localhost:8080/users")!
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethods.post.rawValue
        
        let encoder = JSONEncoder()
        let httpBody = try? encoder.encode(requestBody)
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro ao buscar dados: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(CreateUserResponse.self, from: data)
                
                print("ID: \(responseData.token)")
                print("Name: \(responseData.user)")
                
            } catch {
                print("Erro ao decodificar os dados JSON: \(error)")
            }
        }
        
        task.resume()
    }
}

