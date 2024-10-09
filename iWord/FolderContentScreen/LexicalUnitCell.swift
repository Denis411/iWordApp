// LexicalUnitCell.swift
// iWord
//
// Created by Denis Ulianov on 10/8/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import UIKit
import SnapKit

final class LexicalUnitCell: UITableViewCell {
    private(set) var lexicalUnit: LexicalUnit?
    private let percentageView = UILabel()
    private let originalWordLabel = UILabel()
    private let mainTranslationLabel = UILabel()
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(percentageView)
        percentageView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(Self.percentageViewInset)
            make.width.equalTo(Self.height - Self.percentageViewInset)
        }
        contentView.addSubview(verticalStack)
        [originalWordLabel, mainTranslationLabel].forEach { label in
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.numberOfLines = 1
        }
        
        verticalStack.addArrangedSubview(originalWordLabel)
        verticalStack.addArrangedSubview(mainTranslationLabel)
        verticalStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(percentageView.snp.leading).inset(20)
            make.verticalEdges.equalToSuperview().inset(20)
        }
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 12
        
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 12
        contentView.layer.shadowOpacity = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: .init(
                top: 0,
                left: Self.horizontalInset,
                bottom: 0,
                right: Self.horizontalInset
            )
        )
    }
    
    func setLexicalUnit(_ lexicalUnit: LexicalUnit) {
        self.lexicalUnit = lexicalUnit
        originalWordLabel.text = lexicalUnit.originalWord
        mainTranslationLabel.text = lexicalUnit.mainTranslation
        percentageView.text = String(lexicalUnit.completionPercentage) + " " + "%"
    }
}

extension LexicalUnitCell {
    static let height: CGFloat = 100
    static let spacingBetweenCells: CGFloat = 5
    static let horizontalInset: CGFloat = 20
    static let percentageViewInset: CGFloat = 10
}
