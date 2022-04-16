//
//  ApiRequest.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 15.04.2022.
//


import Foundation

class ApiRequest{
    
    static let shated = ApiRequest()
    
    private init() {}
    
    func apiData(urlString: String, completion: @escaping (Swift.Result<Data, Error>) -> Void){
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }.resume()
    }
}
