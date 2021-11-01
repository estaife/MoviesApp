//
//  ThumbImageCollectionViewCell.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import UIKit
import Nuke

final internal class ThumbImageCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - INTERNAL PROPERTIES
    static let reuseIdentifier = String(describing: ThumbImageCollectionViewCell.self)
    
    // MARK: - PRIVATE PROPERTIES
    private struct Metrics {
        static let cornerRadius: CGFloat = 12
        static let fadeIn: Double = 0.20
    }
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Metrics.cornerRadius
        return imageView
    }()
    
    // MARK: - INITALIZER
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    internal func subviews() {
        addSubview(bannerImageView)
    }
    
    internal func constraints() {
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        bannerImageView.image = nil
    }
    
    // MARK: - INTERNAL FUNC
    internal func updateView(with imageURL: URL?) {
        if let urlImage = imageURL {
            let request = ImageRequest(url: urlImage)
            let options = ImageLoadingOptions(
                placeholder: .trailerPoster,
                transition: .fadeIn(duration: Metrics.fadeIn)
            )
            Nuke.loadImage(
                with: request,
                options: options,
                into: bannerImageView
            )
        }
    }
}
