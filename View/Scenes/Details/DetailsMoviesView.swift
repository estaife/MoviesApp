//
//  DetailsMoviesGridView.swift
//  View
//
//  Created by Estaife Lima on 24/10/21.
//

import UIKit

protocol DetailsMoviesViewProtocol: AnyObject {
    func didTappedRetry()
}

final class DetailsMoviesView: CustomView {
    
    // MARK: - PUBLIC PROPERTIES
    public var isLoading: Bool {
        activityIndicatorView.isAnimating
    }
    
    // MARK: - PRIVATE PROPERTIES
    private weak var delegate: DetailsMoviesViewProtocol?
    
    private var viewState: ViewState = .loading {
        didSet { transition(to: viewState) }
    }
    
    private struct Strings {
        static let informationTitle = "Opss, estamos trabalhando para melhorar"
        static let informationButtonTitle = "Tentar novamente"
    }
    
    private struct Metrics {
        static let spacing: CGFloat = 20
    }
    
    // MARK: - UI
    private lazy var errorInformationView: InformationView = {
        let view = InformationView(
            title: Strings.informationTitle,
            action: UIAction(
                title: Strings.informationButtonTitle,
                handler: { [weak self] _ in
                    self?.delegate?.didTappedRetry()
                }
            )
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .systemGray
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    // MARK: - INITALIZER
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    public func subviews() {
        addSubview(activityIndicatorView)
        addSubview(errorInformationView)
    }
    
    public func constraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Metrics.spacing
            ),
            
            errorInformationView.topAnchor.constraint(equalTo: topAnchor),
            errorInformationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorInformationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorInformationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func style() {
        backgroundColor = .systemBackground
    }
}

// MARK: - DetailsMoviesViewType
extension DetailsMoviesView: DetailsMoviesViewType {
    public func updateView(with viewState: DetailsMoviesViewState) {
        DispatchQueue.main.async {
            switch viewState {
            case .hasData(_):
                self.viewState = .hasData
            case .startLoading:
                self.viewState = .loading
            case .stopLoading:
                self.viewState = .hasData
            case .error(let error):
                self.viewState = .error
                self.errorInformationView.subtitle = error
                break
            }
        }
    }
}

// MARK: - ViewStateProtocol
extension DetailsMoviesView: ViewStateProtocol {
    public func transition(to state: ViewState) {
        switch state {
        case .loading:
            activityIndicatorView.startAnimating()
        case .hasData:
            errorInformationView.isHidden = true
            activityIndicatorView.stopAnimating()
        case .error:
            errorInformationView.isHidden = false
        }
    }
}
