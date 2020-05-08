//
//  GoalCell.swift
//  Macros
//
//  Created by Jose Aguilar on 5/4/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import UIKit

/// Set a title, subtitle, and adjust the progress view. Use the custom register and dequeue functions instead of the regular collectionview functions.
class GoalCell: UICollectionViewCell {

    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        return titleLabel
    }()

    var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        return subtitleLabel
    }()

    var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .systemGray
        progressView.progressTintColor = .systemBlue
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 2
        progressView.subviews[1].clipsToBounds = true
        progressView.subviews[1].layer.cornerRadius = 2
        return progressView
    }()

    override var tintColor: UIColor! {
        didSet {
            progressView.progressTintColor = self.tintColor
        }
    }

    static func register(_ collectionView: UICollectionView) {
        collectionView.register(GoalCell.self, forCellWithReuseIdentifier: "GoalCell")
    }

    static func dequeue(_ collectionView: UICollectionView, for indexPath: IndexPath) -> GoalCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalCell", for: indexPath) as! GoalCell
        cell.setupViews()
        return cell
    }

    private func setupViews() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(progressView)
        setupSubviews()
    }

    private func setupSubviews() {
        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            progressView.topAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.bottomAnchor, constant: 4),
            progressView.heightAnchor.constraint(greaterThanOrEqualToConstant: 4),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                contentView.backgroundColor = self.tintColor.withAlphaComponent(0.3)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = .secondarySystemBackground
                }
            }
        }
    }
}
