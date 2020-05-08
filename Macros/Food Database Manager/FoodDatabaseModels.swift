//
//  FoodDatabaseModels.swift
//  Macros
//
//  Created by Jose Aguilar on 5/7/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let totalHits: Int
    let currentPage: Int
    let totalPages: Int
    let foods: [SearchResultFood]
}

struct SearchResultFood: Codable {
    let fdcId: Int
    let dataType: String?
    let description: String
    let foodCode: String?
    let foodNutrients: [AbridgedFoodNutrient]
    let publicationDate: String?
    let scientificName: String?
    let brandOwner: String?
    let gtinUpc: String?
    let ingredients: String?
    let ndbNumber: String?
    let additionalDescriptions: String?
    let allHighlightFields: String?
    let score: Float?
}

struct AbridgedFoodNutrient: Codable {
    let number: Int?
    let name: String?
    let amount: Float?
    let unitName: String?
    let derivationCode: String?
    let derivationDescription: String?
}

struct FoodModel: Codable { // TODO: Build the food model.
    let description: String
}
