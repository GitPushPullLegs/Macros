//
//  ViewController.swift
//  Macros
//
//  Created by Jose Aguilar on 5/4/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        setupNavbar()
        setupToolbar()
        setupCollectionView()
    }

    private func setupNavbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.title = "Today"
    }

    private func setupCollectionView() {
        GoalCell.register(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    var addFoodToolBarItem: UIBarButtonItem = {
        let pseudoButton = UIButton(type: .custom)
        pseudoButton.setTitle("Add Food", for: .normal)
        pseudoButton.setTitleColor(.label, for: .normal)
        pseudoButton.setTitleColor(UIColor.label.withAlphaComponent(0.3), for: .highlighted)
        let font = UIFont.preferredFont(forTextStyle: .title2)
        let desc = font.fontDescriptor.withSymbolicTraits(.traitBold)

        pseudoButton.titleLabel?.font = UIFont(descriptor: desc!, size: desc!.pointSize)
        pseudoButton.adjustsImageWhenHighlighted = false
        let button = UIBarButtonItem(customView: pseudoButton)
        return button
    }()
    var dynamicSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    var scanBarcodeItem: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(pointSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold)
        let image = UIImage(systemName: "barcode.viewfinder", withConfiguration: config)
        let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        item.tintColor = .label
        return item
    }()
    var fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    var quickEntryItem: UIBarButtonItem = {
        let config = UIImage.SymbolConfiguration(pointSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .bold)
        let image = UIImage(systemName: "bolt.fill", withConfiguration: config)
        let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        item.tintColor = .label
        return item
    }()

    private func setupToolbar() {
        navigationController?.setToolbarHidden(false, animated: false)
        fixedSpace.width = 24
        toolbarItems = [addFoodToolBarItem, dynamicSpace, scanBarcodeItem, fixedSpace, quickEntryItem]
    }
}

extension DemoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((UIScreen.main.bounds.width - 40)/2), height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let caloriesCell = GoalCell.dequeue(collectionView, for: indexPath)
            caloriesCell.tintColor = .systemRed
            caloriesCell.titleLabel.text = "Calories"
            caloriesCell.subtitleLabel.text = "324 remaining"
            caloriesCell.progressView.setProgress(0.56, animated: false)
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
}

