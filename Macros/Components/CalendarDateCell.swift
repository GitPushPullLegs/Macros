//
//  CalendarDateCell.swift
//  Macros
//
//  Created by Jose Aguilar on 5/14/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarDateCell: JTAppleCell {
    var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        return dateLabel
    }()

    var proteinProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .systemGray
        progressView.progressTintColor = .systemYellow
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 2
        progressView.subviews[1].clipsToBounds = true
        progressView.subviews[1].layer.cornerRadius = 2
        return progressView
    }()

    var caloriesProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .systemGray
        progressView.progressTintColor = .systemRed
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 2
        progressView.subviews[1].clipsToBounds = true
        progressView.subviews[1].layer.cornerRadius = 2
        return progressView
    }()

    static func register(_ collectionView: UICollectionView) {
        collectionView.register(CalendarDateCell.self, forCellWithReuseIdentifier: "dateCell")
    }

    static func dequeue(_ collectionView: UICollectionView, for indexPath: IndexPath) -> CalendarDateCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! CalendarDateCell
        cell.setupViews()
        return cell
    }

    func setupViews() {
        contentView.addSubviews([dateLabel, caloriesProgressView, proteinProgressView])
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            caloriesProgressView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            caloriesProgressView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            caloriesProgressView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            caloriesProgressView.heightAnchor.constraint(equalToConstant: 4),
            proteinProgressView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            proteinProgressView.topAnchor.constraint(equalTo: caloriesProgressView.bottomAnchor, constant: 1),
            proteinProgressView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            proteinProgressView.heightAnchor.constraint(equalToConstant: 4),
            proteinProgressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
