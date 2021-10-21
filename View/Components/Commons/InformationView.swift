//
//  InformationView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

final class InformationView: CustomView {
    
    // MARK: - PUBLIC PROPERTIES
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var subtitle: String? = "" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    // MARK: - PRIVATE PROPERTIES
    private struct Metrics {
        static let spacing: CGFloat = 10
        static let margin: CGFloat = 52
        static let heightSubtitleMultiplier: CGFloat = 0.10
    }
    
    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        label.contentMode = .top
        return label
    }()
    
    // MARK: - INITALIZER
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public init(title: String, subtitle: String) {
        super.init(frame: .zero)
        self.title = title
        self.subtitle = subtitle
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    public func subviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    public func constraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Metrics.margin),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.spacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.margin),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.margin),
            subtitleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Metrics.heightSubtitleMultiplier)
        ])
    }
}
