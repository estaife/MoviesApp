//
//  EmbedYoutubeVideoViewController.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit
import WebKit

final class EmbedYoutubeVideoViewController: CustomViewController {

    // MARK: - PRIVATE PROPERTIES
    private let url: URL
    
    private struct Metrics {
        static let margin: CGFloat = 8
        static let sizeButton: CGFloat = 50
    }
    
    // MARK: - UI
    private lazy var webConfiguration: WKWebViewConfiguration = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = true
        return webConfiguration
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.isOpaque = false
        webView.load(URLRequest(url: url))
        return webView
    }()
    
    private lazy var dismissButton: ELButton = {
        let button = ELButton(effectStyle: .dark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.size = CGSize(width: Metrics.sizeButton, height: Metrics.sizeButton)
        button.cornerRadius = Metrics.sizeButton / 5
        button.image = .dismiss
        button.textColor = .systemGray
        button.onTouchUpInside = { [unowned self] in
            self.webView.stopLoading()
            self.dismiss(animated: true)
        }
        return button
    }()
    
    // MARK: - INITIALIZERS
    internal init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override internal func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK: - VIEW HIERARCHY
    internal func subviews() {
        view = webView
        webView.addSubview(dismissButton)
    }
    
    internal func constraints() {
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(
                equalTo: webView.topAnchor,
                constant: Metrics.margin * 4
            ),
            dismissButton.leadingAnchor.constraint(
                equalTo: webView.leadingAnchor,
                constant: Metrics.margin
            )
        ])
    }
    
    internal func style() {
        view.backgroundColor = .black
    }
}
