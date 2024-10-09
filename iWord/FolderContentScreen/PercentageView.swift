// ProcentRoundView.swift
// iWord
//
// Created by Denis Ulianov on 10/9/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org

import UIKit
import SnapKit

/// If you do not set background color then the center of your view will be white
final class PercentageView: UIView {
    private var percentage: UInt8?
    private let checkMarkImageView: UIImageView = {
        let checkMarkView = UIImageView()
        let image = UIImage(systemName: "checkmark.circle")
        checkMarkView.image = image
        checkMarkView.tintColor = .orange
        return checkMarkView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 200)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let edge = min(rect.width, rect.height)
        guard (percentage ?? 0) < 100 else {
            self.layer.backgroundColor = UIColor.green.cgColor
            self.layer.cornerRadius = edge / 2
            return
        }
        
        let colorfulGradient = createColorfulGradient(rect, percentage: percentage)
        layer.addSublayer(colorfulGradient)
        
        let roundLayer = CALayer()
        roundLayer.frame =
        rect.insetBy(dx: Self.lineWidth, dy: Self.lineWidth)
        if let backgroundColor {
            roundLayer.backgroundColor = backgroundColor.cgColor
        } else {
            roundLayer.backgroundColor = UIColor.white.cgColor
        }
        
        roundLayer.cornerRadius = roundLayer.bounds.width / 2
        layer.addSublayer(roundLayer)
        layer.addSublayer(label.layer)
    }
    
    private func createColorfulGradient(_ rect: CGRect, percentage: UInt8?) -> CALayer {
        // gradient
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        gradient.type = .conic
        
        gradient.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor
        ]
        gradient.frame = bounds
        guard let percentage else {
            gradient.cornerRadius = frame.width / 2
            return gradient
        }
        
        //shape
        let shapeLayer = CAShapeLayer()
        let maxPercentage: CGFloat = 100
        let currentPercentage = CGFloat(percentage)
        let maxDegree: CGFloat = 360
        let currentDegree = (maxDegree / maxPercentage) * currentPercentage
        let endAngle = currentDegree
        let circlePath = UIBezierPath()
        let startPoint = CGPoint(x: rect.midX, y: rect.midY)
        circlePath.move(to: startPoint)
        
        let arcCenter = CGPoint(
            x: bounds.size.width / 2,
            y: bounds.size.height / 2
        )
        let arcRadius = rect.size.height / 2
        circlePath.addArc(
            withCenter: arcCenter,
            radius: arcRadius,
            startAngle: degreeToPi(degree: -90),
            endAngle: degreeToPi(degree: endAngle - 90),
            clockwise: true
        )

        shapeLayer.path = circlePath.cgPath
        gradient.mask = shapeLayer
        
        return gradient
    }
    
    private func degreeToPi(degree: CGFloat) -> CGFloat {
        let oneDegree = 1 * CGFloat.pi / 180
        return oneDegree * degree
    }
}

// MARK: - Public methods
extension PercentageView {
    func updatePercentage(_ percentage: UInt8) {
        self.percentage = percentage
        label.text = String(percentage) + " " + "%"
        
        if percentage >= 100 {
            label.removeFromSuperview()
            self.addSubview(checkMarkImageView)
            checkMarkImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
        } else {
            checkMarkImageView.removeFromSuperview()
            self.addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                    .inset(Self.lineWidth * 2)
            }
        }
        
        self.setNeedsDisplay()
    }
}

extension PercentageView {
    static let lineWidth: CGFloat = 10
}

import SwiftUI
struct PercentView: UIViewRepresentable {
    private let percentageView = PercentageView()
    func makeUIView(context: Context) -> some UIView {
        percentageView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func updatePercentage(_ percentage: UInt8) {
        percentageView.updatePercentage(percentage)
    }
}

#Preview {
    let first: PercentView = {
        let view = PercentView()
        view.updatePercentage(200)
        return view
    }()
    let second: PercentView = {
        let view = PercentView()
        view.updatePercentage(80)
        return view
    }()
    VStack {
        first
            .frame(width: 300, height: 300)
        second
            .frame(width: 300, height: 300)
    }
}
