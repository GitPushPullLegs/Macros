//
//  HealthKitManager.swift
//  Macros
//
//  Created by Jose Aguilar on 5/8/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager: HealthKitProtocol {

    var healthStore: HKHealthStore?
    var isHealthKitAvailable = false

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            isHealthKitAvailable = true
            self.healthStore = HKHealthStore()
        } else {
            //TODO: Handle HealthKit unavailable.
            print("HealthKit unavailable.")
        }
    }

    func requestAccess() {
        guard let healthStore = healthStore else { fatalError() } //TODO: Handle HealthStore not enabled.

        let shareTypes: Set<HKSampleType> = Set([
            HKSampleType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKSampleType.quantityType(forIdentifier: .dietaryProtein)!,
            HKSampleType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
            HKSampleType.quantityType(forIdentifier: .dietaryFatTotal)!,
            HKSampleType.quantityType(forIdentifier: .bodyFatPercentage)!,
            HKSampleType.quantityType(forIdentifier: .bodyMass)!
        ])

        let readTypes: Set<HKObjectType> = Set([
            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKObjectType.quantityType(forIdentifier: .dietaryProtein)!,
            HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!,
            HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
            HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!
        ])

        healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error) in
            // Success does not mean access was granted. Just that the promp was shown to the user to enable or prevent access.
            if success {
                print("HealthKit Data Access Sheet displayed and dismissed.")
            } else {
                print(error!) //Handle fail.
            }
        }
    }

    func isAuthorized(toShare object: HKObjectType) -> HKAuthorizationStatus {
        guard let healthStore = healthStore else { fatalError() }
        return healthStore.authorizationStatus(for: object)
    }

    func fetchNutrientDetails(of sample: HKSampleType, startDate: Date, endDate: Date, completion: @escaping ([HKSample]?) -> Void) {
        guard let healthStore = healthStore else { completion(nil); return }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate, .strictEndDate])

        let query = HKSampleQuery(sampleType: sample, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (_, results, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            completion(results)
        }

        healthStore.execute(query)
    }

    @discardableResult
    func observe(sample: HKSampleType) -> HKObserverQuery {
        guard let healthStore = healthStore else { fatalError() }

        let query = HKObserverQuery(sampleType: sample, predicate: nil) { (query, completionHandler, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }

            // This doesn't tell me what's changed, just that there's been a change. Here I should react to the observation.

        }

        healthStore.execute(query)

        return query
    }

    func stopObserving(_ query: HKObserverQuery) {
        guard let healthStore = healthStore else { fatalError() }

        healthStore.stop(query)
    }
}
