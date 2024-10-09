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
import SnapKit

final class FolderContentView: UIView {
    private var listOfUnits: [LexicalUnit] = [LexicalUnit(), LexicalUnit(), LexicalUnit(), LexicalUnit(), LexicalUnit(), LexicalUnit(), LexicalUnit(), LexicalUnit()]
    private let tableView = UITableView()
    private let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = FolderContentView.addButtonEdge / 2
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 12
        let plusImage = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 60))
        )
        button.setImage(plusImage, for: .normal)
        return button
        
    }()
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
        tableView.separatorStyle = .none
        tableView.clipsToBounds = false
        self.addSubview(tableView)
        self.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(Self.addButtonEdge)
            make.trailing.bottom.equalToSuperview().inset(20)
        }
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonAction() {
        listOfUnits.append(.init())
        tableView.reloadData()
    }
}

extension FolderContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LexicalUnitCell.height + LexicalUnitCell.spacingBetweenCells
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfUnits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "LU") as! LexicalUnitCell
        dequeuedCell.setLexicalUnit(listOfUnits[indexPath.row])
        return dequeuedCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfUnits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        print("Open edit view")
    }
}

extension FolderContentView {
    static let addButtonEdge: CGFloat = 100
}
