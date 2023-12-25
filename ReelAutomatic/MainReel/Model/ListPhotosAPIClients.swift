//
//  ListPhotosAPIClients.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 04/12/23.
//

import Foundation

final class ListPhotosAPIClients {
    
    func getListPhotos(onSuccess: @escaping(_ listPhoto: SearchPhotosModel) -> Void, onFailure: @escaping(_ error: Error) -> Void) {
        var urlBuilder = URLComponents(string: "https://api.pexels.com/videos/search")
        urlBuilder?.queryItems = [
            URLQueryItem(name: "query", value: "nature"),
            URLQueryItem(name: "per_page", value: "20")
        ]
        
        guard let url = urlBuilder?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "ChI0WanH1jmsQF5FsfjM926nyRMJQcpdWgRCYwqhxhjAYIk9FbJKzqna"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let products = try JSONDecoder().decode(SearchPhotosModel.self, from: data ?? Data())
                onSuccess(products)
            }
            catch {
                print("Error al decodificar")
                print(error)
                onFailure(error)
            }
        }.resume()
    }
    
}
