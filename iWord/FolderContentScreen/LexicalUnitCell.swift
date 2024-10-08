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
    private let mainTranslationTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
        contentView.addSubview(mainTranslationTitle)
        mainTranslationTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLexicalUnit(_ lexicalUnit: LexicalUnit) {
        self.lexicalUnit = lexicalUnit
        mainTranslationTitle.text = lexicalUnit.mainTranslation
    }
}
