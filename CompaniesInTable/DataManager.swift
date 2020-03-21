//
//  DataManager.swift
//  CompaniesInTable
//
//  Created by  mac on 3/19/20.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Foundation

struct DataManager {
    
    let baseUrl = "https://api.myjson.com/bins/vi56v"
    
    func fetchDataFromFile() -> [String]? {
         guard let file = Bundle.main.path(forResource: "companies", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: file), options: []),
            let companiesModel = try? JSONDecoder().decode(DataModel.self, from: data)
            else {
                return nil
            }
        let companies = companiesModel.companies
        return companies
    }
    
    func fetchData(countriesCompletionHandler: @escaping ([String]?, Error?) -> Void) {
        let url = URL(string: baseUrl)
        let task = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error != nil {
                countriesCompletionHandler(nil, error)
            }
            if data != nil {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(DataModel.self, from: data!)
                    countriesCompletionHandler(decodedData.companies, nil)
                    
                } catch {
                    countriesCompletionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
}
