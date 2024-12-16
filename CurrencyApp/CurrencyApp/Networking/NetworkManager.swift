//
//  NetworkingManager.swift
//  CurrencyApp
//
//  Created by Abdulvoxid on 15/12/24.
//

import Foundation



class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getData(handler: @escaping ([CurrencyData]?) -> ()) {
        
        guard let url = URL(string: "https://cbu.uz/uz/arkhiv-kursov-valyut/json/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let response = response as? HTTPURLResponse
            
            if let data = data, let response = response, response.statusCode == 200 {
                if let decodeCurrencyData = try? JSONDecoder().decode([CurrencyData].self, from: data) {
                    DispatchQueue.main.async {
                        handler(decodeCurrencyData)
                    }
                    return
                }
            }
            handler(nil)
        }.resume()
    }
}
