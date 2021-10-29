//
//  AlertController.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

// MARK: - PUBLIC PROPERTIES
public enum AlertControllerStyle {
    case error
    case success
    case warning
}

internal final class AlertController: CustomViewController {
    
    // MARK: - Properties
    private let alertStyle: AlertControllerStyle
    private var message: String?
    
    private var image: UIImage? {
        switch alertStyle {
        case .error:
            return .error
        case .success:
            return .success
        case .warning:
            return .warning
        }
    }
    
    // MARK: - PRIVATE PROPERTIES
    private struct Metrics {
        static let spacing: CGFloat = 18
        static let size: CGFloat = 200
        static let cornerRadius: CGFloat = 12
        static let heightMultiplierTitle: CGFloat = 0.4
    }
    
    // MARK: - UI
    private lazy var contentView: UIView = {
        let x = self.view.bounds.width / 2 - (Metrics.size / 2)
        let y = self.view.bounds.height / 2 - (Metrics.size / 2)
        let rect = CGRect(x: x, y: y, width: Metrics.size, height: Metrics.size)
        let view = UIView(frame: rect)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "titleLabel titleLabel fee eetitleLabel"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = Metrics.cornerRadius
        return view
    }()
    
    // MARK: - INITIALIZERS
    internal init(alertStyle: AlertControllerStyle, message: String? = nil) {
        self.alertStyle = alertStyle
        super.init(nibName: nil, bundle: nil)
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    internal override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        dismiss()
    }
    
    // MARK: - VIEW HIERARCHY
    internal func subviews() {
        view.addSubview(contentView)
        contentView.addSubview(blurView)
        contentView.addSubview(imageView)
        contentView.addSubview(messageLabel)
    }
    
    internal func constraints() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.spacing * 2
            ),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        if message != nil {
            activateConstraintWithMessage()
        } else {
            activateConstraintWithoutMessage()
        }
    }
    
    internal func style() {
        view.backgroundColor = .clear
        imageView.image = image
        messageLabel.text = message
    }
    
    private func activateConstraintWithMessage() {
        NSLayoutConstraint.activate([
            messageLabel.heightAnchor.constraint(
                equalTo: blurView.heightAnchor,
                multiplier: Metrics.heightMultiplierTitle
            ),
            messageLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.spacing
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Metrics.spacing
            ),
            messageLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.spacing
            ),
            imageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor)
        ])
    }
    
    private func activateConstraintWithoutMessage() {
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.spacing * 2
            )
        ])
    }
    
    // MARK: - PRIVATE METHODS
    private func dismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
