// FolderContentView.swift
// iWord
//
// Created by Denis Ulianov on 10/8/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import UIKit

struct LexicalUnit {
    let mainTranslation: String
    
    init() {
        self.mainTranslation = "Text"
    }
}

final class LexicalUnitCell: UITableViewCell {
    private(set) var lexicalUnit: LexicalUnit?
    private let mainTranslationTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
        contentView.addSubview(mainTranslationTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLexicalUnit(_ lexicalUnit: LexicalUnit) {
        self.lexicalUnit = lexicalUnit
        mainTranslationTitle.text = lexicalUnit.mainTranslation
    }
}

final class FolderContentView: UIView {
    private let listOfUnits: [LexicalUnit] = [LexicalUnit(), LexicalUnit()]
    private let tableView = UITableView()
    override var frame: CGRect {
        didSet {
            tableView.frame = self.frame
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LexicalUnitCell.self, forCellReuseIdentifier: "LU")
        self.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FolderContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfUnits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "LU") as! LexicalUnitCell
        dequeuedCell.setLexicalUnit(listOfUnits[indexPath.row])
        return dequeuedCell
    }
}
