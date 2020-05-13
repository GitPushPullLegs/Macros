//
//  HealthKitProtocol.swift
//  Macros
//
//  Created by Jose Aguilar on 5/8/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthKitProtocol {
    var isHealthKitAvailable: Bool { get set }
    func requestAccess()
    func isAuthorized(toShare object: HKObjectType) -> HKAuthorizationStatus
    func fetchNutrientDetails(of sample: HKSampleType, startDate: Date, endDate: Date, completion: @escaping ([HKSample]?) -> Void)
    @discardableResult
    func observe(sample: HKSampleType) -> HKObserverQuery
    func stopObserving(_ query: HKObserverQuery)
}
