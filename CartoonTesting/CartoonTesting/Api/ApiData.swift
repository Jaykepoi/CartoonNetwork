//
//  ApiData.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 15.04.2022.
//


import Foundation

class ApiData {
    
    static let shared = ApiData()
    
    private init() {}
    
    public let firstPage = "https://rickandmortyapi.com/api/character/?page=1"
    
    public func get20Sheets(urlString: String, responce: @escaping(apiCartoon?, Error?) -> Void){
        
        ApiRequest.shated.apiData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode(apiCartoon.self, from: data)
                    responce(data, nil)
                    
                } catch let jsonerror{
                    print("Failed to decode JSON: \(jsonerror.localizedDescription)")
                }
                
            case .failure(let error):
                print("Error received reuestiing data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
    
    public func getDetailHuman(id: Int, responce: @escaping(apiCharacter?, Error?) -> Void){

        let urlString = "https://rickandmortyapi.com/api/character/\(id)"
        
        ApiRequest.shated.apiData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode(apiCharacter.self, from: data)
                    responce(data, nil)
                    
                } catch let jsonerror{
                    print("Failed to decode JSON: \(jsonerror.localizedDescription)")
                }
                
            case .failure(let error):
                print("Error received reuestiing data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
