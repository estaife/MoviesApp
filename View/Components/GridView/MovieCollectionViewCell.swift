//
//  MovieCollectionViewCell.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit
import Nuke
import Presenter

public class MovieCollectionViewCell: CustomCollectionViewCell {
    
    // MARK: - PUBLIC PROPERTIES
    static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)
    
    // MARK: - PRIVATE PROPERTIES
    private struct Metrics {
        static let margin: CGFloat = 16
        static let consensusViewSize: CGSize = .init(width: 50, height: 50)
        static let heightBottomStack: CGFloat = 50
        static let cornerRadius: CGFloat = 12
        static let fadeIn: Double = 0.20
    }
    
    // MARK: - UI
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Metrics.cornerRadius
        return imageView
    }()
    
    private lazy var consensusView: ConsensusView = {
        let view = ConsensusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = 2
        return view
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textColor = .systemGray2
        return label
    }()
    
    // MARK: - INITALIZER
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    public func subviews() {
        addSubview(logoImageView)
        addSubview(bottomStackView)
        addSubview(consensusView)
        bottomStackView.addArrangedSubview(titleLabel)
        bottomStackView.addArrangedSubview(releaseDateLabel)
    }
    
    public func constraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.bottomAnchor.constraint(
                equalTo: bottomStackView.topAnchor,
                constant: -Metrics.heightBottomStack / 2
            ),
            
            consensusView.leadingAnchor.constraint(
                equalTo: logoImageView.leadingAnchor,
                constant: Metrics.margin
            ),
            consensusView.centerYAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            consensusView.heightAnchor.constraint(equalToConstant: Metrics.consensusViewSize.height),
            consensusView.widthAnchor.constraint(equalToConstant: Metrics.consensusViewSize.width),
            
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: Metrics.heightBottomStack)
        ])
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
        titleLabel.text = nil
        releaseDateLabel.text = nil
    }
    
    // MARK: - PUBLIC FUNC
    public func updateView(with viewModel: MovieViewModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.title
            self.releaseDateLabel.text = viewModel.releaseYear
            self.consensusView.setValue(viewModel.voteAverage)
            self.loadImage(url: viewModel.posterPathUrl)
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func loadImage(url: URL?) {
        if let urlImage = url {
            let request = ImageRequest(url: urlImage)
            let options = ImageLoadingOptions(
                placeholder: .moviePoster,
                transition: .fadeIn(duration: Metrics.fadeIn)
            )
            Nuke.loadImage(with: request, options: options, into: logoImageView)
        }
    }
}
