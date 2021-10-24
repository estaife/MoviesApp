//
//  ConsensusView.swift
//  View
//
//  Created by Estaife Lima on 21/10/21.
//

import UIKit

final class ConsensusView: CustomView {
    
    // MARK: - PRIVATE PROPERTIES
    private struct Metrics {
        static let viewSize: CGSize = .init(width: 50, height: 50)
        static let lineWidthCircleLayer: CGFloat = 10
        static let lineWidthProgressLayer: CGFloat = 4
        static let durationProgressAnimation: CFTimeInterval = 0.1
        static let percentFontSize: CGFloat = 6
        static let valueFontSize: CGFloat = 10
    }
    
    // MARK: - LAYER
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var rect: CGRect = .zero
    private var circularPath: (_ rect: CGRect) -> UIBezierPath = { (rect: CGRect)  in
        let arcCenter = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        return .init(
                arcCenter: arcCenter,
                radius: rect.width / 3,
                startAngle: -.pi / 2,
                endAngle: 3 * .pi / 2,
                clockwise: true
            )
    }
    
    // MARK: - UI
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.layer.zPosition = 1
        return label
    }()
    
    // MARK: - INITIALIZER
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VIEW HIERARCHY
    public func subviews() {
        addSubview(percentLabel)
    }
    
    public func constraints() {
        NSLayoutConstraint.activate([
            percentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            percentLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func style() {
        backgroundColor = .clear
    }
    
    // MARK: - PRIVATE FUNC
    private func mutableAttributedString(value: String) -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let percentAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: Metrics.percentFontSize,
                weight: .semibold
            )
        ]
        let valueAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: Metrics.valueFontSize,
                weight: .semibold
            )
        ]
        mutableAttributedString.append(
            .init(string: value, attributes: valueAttributes)
        )
        mutableAttributedString.append(
            .init(string: "%", attributes: percentAttributes)
        )
        return mutableAttributedString
    }
    
    private func makeCircularProgress(_ value: Int) {
        let circularBasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularBasicAnimation.duration = Metrics.durationProgressAnimation
        circularBasicAnimation.toValue = Double(value) / 100.0
        circularBasicAnimation.fillMode = .forwards
        circularBasicAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularBasicAnimation, forKey: "circularBasicAnimation")
        progressLayer.strokeColor = ColorConsensusView.getStyleStroke(value: value).color
        percentLabel.attributedText = mutableAttributedString(value: String(value))
    }
    
    private func makeCircleBase() {
        circleLayer.path = circularPath(rect).cgPath
        circleLayer.fillColor = UIColor.darkGray.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = Metrics.lineWidthCircleLayer
        circleLayer.strokeColor = UIColor.darkGray.cgColor
        progressLayer.path = circularPath(rect).cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = Metrics.lineWidthProgressLayer
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    // MARK: - PUBLIC FUNC
    public func setValue(_ value: Int) {
        rect = .init(origin: .zero, size: Metrics.viewSize)
        makeCircleBase()
        makeCircularProgress(value)
    }
}
