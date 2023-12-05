//
//  ListPhotosAPIClients.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 04/12/23.
//

import Foundation

final class ListPhotosAPIClients {
    
    func getListPhotos() {
        var urlBuilder = URLComponents(string: "https://api.pexels.com/v1/search")
        urlBuilder?.queryItems = [
            URLQueryItem(name: "query", value: "nature")
        ]
        
        guard let url = urlBuilder?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "ChI0WanH1jmsQF5FsfjM926nyRMJQcpdWgRCYwqhxhjAYIk9FbJKzqna"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let products = try JSONDecoder().decode(SearchPhotosModel.self, from: data ?? Data())
                print("Datos")
                print(products)
            }
            catch {
                print("Error al decodificar")
                print(error)
            }
        }.resume()
    }
    
}
