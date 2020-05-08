//
//  FoodDatabaseProtocol.swift
//  Macros
//
//  Created by Jose Aguilar on 5/7/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import Foundation

protocol FoodDatabaseProtocol {
    typealias fdcID = String

    func fetchFoodDetails(for fdcID: fdcID, format: String?, nutrients: [Int]?,
                          completion: @escaping (FoodModel) -> ())

    func fetchFoodDetails(for: [fdcID], format: String?, nutrients: [Int]?,
                          completion: @escaping ([FoodModel]) -> ())

    func fetchFoods(matching criteria: String, dataType: [String]?, pageSize: Int?, pageNumber: Int?, sortBy: String, sortOrder: String, brandOwner: String,
                    completion: @escaping (SearchResult) -> ())
}
