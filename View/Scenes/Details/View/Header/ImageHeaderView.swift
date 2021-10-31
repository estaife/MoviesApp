//
//  ImageHeaderView.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import UIKit
import Nuke

final internal class ImageHeaderView: CustomCollectionReusableView {
    
    // MARK: - internal PROPERTIES
    internal static let identifier = String(describing: ImageHeaderView.self)
    
    private var viewState: ViewState = .loading {
        didSet { transition(to: viewState) }
    }
    
    // MARK: - PRIVATE PROPERTIES
    private struct Metrics {
        static let spacing: CGFloat = 2
        static let lineViewHeight: CGFloat = 0.5
        static let sideMargin: CGFloat = 32
        static let multiplierHeight: CGFloat = 0.6
        static let locations: [NSNumber] = [0.2, 0.5]
        static let sizeIcons: CGFloat = 50
        static let widthStackViewTrailingContent: CGFloat = 200
    }
    
    private struct Strings {
        static let consensusViewDescription: String = "Classificação Geral"
    }
    
    // MARK: - UI
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.init(white: 0, alpha: 0).cgColor,
            UIColor.init(white: 0, alpha: 1).cgColor
        ]
        gradient.locations = Metrics.locations
        return gradient
    }()
    
    private lazy var blurGradientView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var containterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var stackViewTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.spacing
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var stackViewIcons: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.sideMargin
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var consensusView: ConsensusView = {
        let view = ConsensusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = 4
        return view
    }()
    
    private lazy var consensusViewDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = Strings.consensusViewDescription
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    private lazy var stackViewTrailingContent: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Metrics.spacing
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateRealeaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(white: 0.4, alpha: 0.4)
        return view
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        addSubview(blurGradientView)
        addSubview(containterView)
        containterView.addSubview(stackViewTitle)
        stackViewTitle.addArrangedSubview(titleLabel)
        stackViewTitle.addArrangedSubview(taglineLabel)
        containterView.addSubview(stackViewIcons)
        containterView.addSubview(consensusView)
        containterView.addSubview(consensusViewDescriptionLabel)
        containterView.addSubview(lineView)
        containterView.addSubview(overviewLabel)
        containterView.addSubview(stackViewTrailingContent)
        stackViewTrailingContent.addArrangedSubview(genresLabel)
        stackViewTrailingContent.addArrangedSubview(dateRealeaseLabel)
    }
    
    internal func constraints() {
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blurGradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurGradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurGradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurGradientView.heightAnchor.constraint(
                equalToConstant: bounds.height * Metrics.multiplierHeight
            ),
            
            containterView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containterView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containterView.heightAnchor.constraint(
                equalToConstant: bounds.height * Metrics.multiplierHeight / 1.9
            ),
            
            stackViewTitle.topAnchor.constraint(
                equalTo: containterView.topAnchor,
                constant: Metrics.spacing * 6
            ),
            stackViewTitle.leadingAnchor.constraint(
                equalTo: containterView.leadingAnchor,
                constant: Metrics.sideMargin
            ),
            stackViewTitle.trailingAnchor.constraint(
                equalTo: consensusView.leadingAnchor,
                constant: -Metrics.sideMargin
            ),
            
            consensusView.centerYAnchor.constraint(
                equalTo: stackViewTitle.centerYAnchor
            ),
            consensusView.trailingAnchor.constraint(
                lessThanOrEqualTo: containterView.trailingAnchor,
                constant: -Metrics.sideMargin
            ),
            consensusView.heightAnchor.constraint(equalToConstant: Metrics.sizeIcons),
            consensusView.widthAnchor.constraint(equalToConstant: Metrics.sizeIcons),
            
            consensusViewDescriptionLabel.centerXAnchor.constraint(equalTo: consensusView.centerXAnchor),
            consensusViewDescriptionLabel.topAnchor.constraint(equalTo: consensusView.bottomAnchor),
            
            stackViewIcons.centerYAnchor.constraint(equalTo: stackViewTitle.centerYAnchor),
            stackViewIcons.trailingAnchor.constraint(
                equalTo: containterView.trailingAnchor,
                constant: -Metrics.sideMargin
            ),
            
            lineView.topAnchor.constraint(
                equalTo: stackViewTitle.bottomAnchor,
                constant: Metrics.sideMargin / 1.5
            ),
            lineView.leadingAnchor.constraint(
                equalTo: containterView.leadingAnchor,
                constant: Metrics.sideMargin
            ),
            lineView.trailingAnchor.constraint(
                equalTo: containterView.trailingAnchor,
                constant: -Metrics.sideMargin
            ),
            lineView.heightAnchor.constraint(equalToConstant: Metrics.lineViewHeight),
            
            overviewLabel.topAnchor.constraint(
                equalTo: lineView.bottomAnchor,
                constant: Metrics.spacing * 2
            ),
            overviewLabel.leadingAnchor.constraint(
                equalTo: containterView.leadingAnchor,
                constant: Metrics.sideMargin
            ),
            overviewLabel.trailingAnchor.constraint(
                equalTo: containterView.trailingAnchor,
                constant: -((Metrics.sideMargin * 1.5) + Metrics.widthStackViewTrailingContent)
            ),
            overviewLabel.bottomAnchor.constraint(
                equalTo: containterView.bottomAnchor,
                constant: -Metrics.spacing * 6
            ),
            stackViewTrailingContent.centerYAnchor.constraint(
                equalTo: overviewLabel.centerYAnchor
            ),
            stackViewTrailingContent.trailingAnchor.constraint(
                equalTo: containterView.trailingAnchor,
                constant: -Metrics.sideMargin
            ),
            stackViewTrailingContent.widthAnchor.constraint(equalToConstant: Metrics.widthStackViewTrailingContent)
        ])
    }
    
    internal func style() {
        backgroundColor = .black
    }
    
    // MARK: - OVERRIDE FUNC
    internal override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = blurGradientView.bounds
        blurGradientView.layer.mask = gradientLayer
    }
    
    // MARK: - PRIVATE FUNC
    private func loadImage(url: URL?) {
        if let urlImage = url {
            let request = ImageRequest(url: urlImage)
            let options = ImageLoadingOptions(
                placeholder: .init(),
                transition: .fadeIn(duration: 0.20)
            )
            Nuke.loadImage(
                with: request,
                options: options,
                into: bannerImageView
            )
        }
    }
}

// MARK: - ImageHeaderViewType
extension ImageHeaderView: ImageHeaderViewType {
    internal func updateView(with viewState: ImageHeaderViewState) {
        DispatchQueue.main.async {
            switch viewState {
            case .hasData(let viewEntity):
                self.consensusView.setValue(viewEntity.voteAverage)
                self.overviewLabel.text = viewEntity.overview
                self.dateRealeaseLabel.attributedText = viewEntity.releaseYearAttributedString
                self.titleLabel.text = viewEntity.title
                self.taglineLabel.text = viewEntity.tagline
                self.genresLabel.attributedText = viewEntity.genresAttributedString
                self.loadImage(url: viewEntity.backdropPathUrl)
                self.viewState = .hasData
            case .loading:
                self.viewState = .loading
            case .error:
                self.viewState = .error
            }
        }
    }
}

// MARK: - ViewStateProtocol
extension ImageHeaderView: ViewStateProtocol {
    internal func transition(to state: ViewState) {
        switch state {
        case .loading:
            self.containterView.isHidden = true
        case .hasData:
            self.containterView.isHidden = false
            self.backgroundColor = .black
            self.blurGradientView.isHidden = false
        case .error:
            self.containterView.isHidden = true
            self.backgroundColor = .systemBackground
            self.blurGradientView.isHidden = true
        }
    }
}
