//
//  TVDemoViewController.swift
//  Macros
//
//  Created by Jose Aguilar on 5/7/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import UIKit
import HealthKit

class TVDemoViewController: UITableViewController {

    let hkManager = HealthKitManager()
    var caloriesConsumed: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let caloriesSample = HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        let AM12 = Date().at(hours: 0, minutes: 0, seconds: 0)
        hkManager.fetchNutrientDetails(of: caloriesSample, startDate: AM12, endDate: Date()) { (samples) in
            var totalCals = 0
            for each in samples! {
                totalCals += Int((each as! HKQuantitySample).quantity.doubleValue(for: HKUnit.kilocalorie()))
            }
            self.caloriesConsumed = totalCals

            DispatchQueue.main.async {
                self.goalCell.reloadItem(at: IndexPath(row: 0, section: 0))
            }
        }
        setupTableView()
    }

    lazy var goalCell: GoalCollectionCell = {
        let goalCell = GoalCollectionCell()
        goalCell.datasource = self
        goalCell.delegate = self
        return goalCell
    }()

    private func setupTableView() {
        tableView.register(GoalCollectionCell.self, forCellReuseIdentifier: "GoalCollectionCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return goalCell
    }
}

extension TVDemoViewController: GoalCollectionCellDataSource, GoalCollectionCellDelegate {
    func numberofCellsInSection(_ section: Int, in collectionView: UICollectionView) -> Int {
        return 1
    }

    func cellForItemAt(_ indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let caloriesCell = GoalCell.dequeue(collectionView, for: indexPath)
            caloriesCell.tintColor = .systemRed
            caloriesCell.titleLabel.text = "Calories"
            caloriesCell.subtitleLabel.text = "\(2750 - caloriesConsumed) remaining"
            caloriesCell.progressView.setProgress(Float(caloriesConsumed)/2750, animated: false)
            return caloriesCell
        case 1:
            let caloriesCell = GoalCell.dequeue(collectionView, for: indexPath)
            caloriesCell.tintColor = .systemYellow
            caloriesCell.titleLabel.text = "Protein"
            caloriesCell.subtitleLabel.text = "16g to go"
            caloriesCell.progressView.setProgress(0.78, animated: false)
            return caloriesCell
        case 2:
            let caloriesCell = GoalCell.dequeue(collectionView, for: indexPath)
            caloriesCell.tintColor = .systemBlue
            caloriesCell.titleLabel.text = "Carbs"
            caloriesCell.subtitleLabel.text = "104g to go"
            caloriesCell.progressView.setProgress(0.5, animated: false)
            return caloriesCell
        case 3:
            let caloriesCell = GoalCell.dequeue(collectionView, for: indexPath)
            caloriesCell.tintColor = .systemGreen
            caloriesCell.titleLabel.text = "Fat"
            caloriesCell.subtitleLabel.text = "4g to go"
            caloriesCell.progressView.setProgress(0.92, animated: false)
            return caloriesCell
        default:
            let caloriesCell = GoalCell.dequeue(collectionView, for: indexPath)
            caloriesCell.tintColor = .systemPurple
            caloriesCell.titleLabel.text = "Workout"
            caloriesCell.subtitleLabel.text = "4 day streak!"
            caloriesCell.progressView.setProgress(1.0, animated: false)
            return caloriesCell
        }
    }
    
    func didSelectItemAt(_ indexPath: IndexPath, in collectionView: UICollectionView) {
    }
}
