//
//  FoodDatabaseManager.swift
//  Macros
//
//  Created by Jose Aguilar on 5/7/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import Foundation

class FoodDatabaseManager: FoodDatabaseProtocol {
    func fetchFoodDetails(for fdcID: fdcID, format: String?, nutrients: [Int]?, completion: @escaping (FoodModel) -> ()) {
        let API_URL = "https://api.nal.usda.gov/fdc/v1/food/\(fdcID)?api_key=\(FoodDatabaseProperties.apiKey)"

        guard let url = URL(string: API_URL) else {
            fatalError()
        }

        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in // TODO: React to responses.
            guard let data = data else { return }
            do {
                let food = try JSONDecoder().decode(FoodModel.self, from: data)
                completion(food)
            } catch {
                print(error)
            }
        }.resume()
    }

    func fetchFoodDetails(for: [fdcID], format: String?, nutrients: [Int]?, completion: @escaping ([FoodModel]) -> ()) {
        print("Foods") //TODO: Build function for multiple foods
    }

    func fetchFoods(matching criteria: String, dataType: [String]?, pageSize: Int?, pageNumber: Int?, sortBy: String, sortOrder: String, brandOwner: String, completion: @escaping (SearchResult) -> ()) {
        let formattedCriteria = criteria.replacingOccurrences(of: " ", with: "%20")
        let API_URL = "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(formattedCriteria)&api_key=\(FoodDatabaseProperties.apiKey)"

        guard let url = URL(string: API_URL) else {
            fatalError()
        }

        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let foods = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(foods)
            } catch {
                print(error)
            }
        }.resume()
    }

}
