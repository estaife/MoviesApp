//
//  ELButton.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

final class ELButton: UIView {
    
    // MARK: - PUBLIC PROPERTIES
    public var onTouchDown: (() -> Void)?
    public var onTouchUpInside: (() -> Void)?
    
    public var size: CGSize = .init() {
        didSet {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
    
    public var cornerRadius: CGFloat = .init() {
        didSet {
            clipsToBounds = false
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
     
    public var text: String? = nil {
        didSet {
            favoriteButton.setTitle(text, for: .normal)
        }
    }
    
    public var textColor: UIColor? = nil {
        didSet {
            favoriteButton.setTitleColor(textColor, for: .normal)
            favoriteButton.imageView?.tintColor = textColor
        }
    }
    
    public var image: UIImage? {
        didSet {
            favoriteButton.setImage(image, for: .normal)
        }
    }

    // MARK: - PRIVATE PROPERTIES
    private var effectStyle: UIBlurEffect.Style
    
    // MARK: - UI
    private lazy var favoriteBlurBackgroundView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: effectStyle))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTouchUpInsideFavoriteButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(didTouchDownFavoriteButton), for: .touchDown)
        return button
    }()
    
    // MARK: - INITALIZER
    public init(effectStyle: UIBlurEffect.Style) {
        self.effectStyle = effectStyle
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VIEW HIERARCHY
    public func commonInit() {
        subviews()
        contraints()
        layoutIfNeeded()
    }
    
    public func subviews() {
        addSubview(favoriteBlurBackgroundView)
        addSubview(favoriteButton)
    }
    
    public func contraints() {
        NSLayoutConstraint.activate([
            favoriteBlurBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            favoriteBlurBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoriteBlurBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteBlurBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor),
            favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - PRIVATE FUNC
    @objc private func didTouchUpInsideFavoriteButton() {
        onTouchUpInside?()
    }
    
    @objc private func didTouchDownFavoriteButton() {
        onTouchDown?()
    }
}
