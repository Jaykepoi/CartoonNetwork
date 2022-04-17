//
//  apiTest.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 15.04.2022.
//

import Foundation

class apiTest {
    
    static let shared = apiTest()
    
    func apiData(from url: String?, with completion: @escaping(apiCartoon) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "nil")
                return
            }
            
            do {
                let cartoonNetwork = try JSONDecoder().decode(apiCartoon.self, from: data)
                DispatchQueue.main.async {
                    completion(cartoonNetwork)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
}
class ImageOne{
    static var shared = ImageOne()
    
    func apiImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "nil")
                return
            }
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}


