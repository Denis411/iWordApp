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
import Repository

final class FolderContentView: UIView {
    private var listOfUnits: [LexicalUnitDataModel]
    private let tableView = UITableView()
    private var startExerciseAction: () -> Void
    private var addNewLexicalUnitAction: () -> Void
    private var deleteLexicalUnitAction: (IndexPath) -> Void
    private var didTapOnLexicalUnitAction: (IndexPath) -> Void
    
    private let startExerciseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = FolderContentView.buttonEdge / 2
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 12
        let plusImage = UIImage(
            systemName: "play",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 60))
        )
        button.setImage(plusImage, for: .normal)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = FolderContentView.buttonEdge / 2
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
    
    init(
        listOfUnits: [LexicalUnitDataModel],
        startExerciseAction: @escaping () -> Void,
        addNewLexicalUnitAction: @escaping () -> Void,
        deleteLexicalUnitAction: @escaping (IndexPath) -> Void,
        didTapOnLexicalUnitAction: @escaping (IndexPath) -> Void
    ) {
        self.listOfUnits = listOfUnits
        self.startExerciseAction = startExerciseAction
        self.addNewLexicalUnitAction = addNewLexicalUnitAction
        self.deleteLexicalUnitAction = deleteLexicalUnitAction
        self.didTapOnLexicalUnitAction = didTapOnLexicalUnitAction
        
        super.init(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LexicalUnitCell.self, forCellReuseIdentifier: "LU")
        tableView.separatorStyle = .none
        tableView.clipsToBounds = false
        self.addSubview(tableView)
        
        self.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(Self.buttonEdge)
            make.trailing.bottom.equalToSuperview().inset(20)
        }
        addButton.addTarget(
            self,
            action: #selector(addButtonAction),
            for: .touchUpInside
        )
        
        self.addSubview(startExerciseButton)
        startExerciseButton.snp.makeConstraints { make in
            make.height.width.equalTo(Self.buttonEdge)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(addButton.snp.top)
                .inset(-20)
        }
        
        startExerciseButton.addTarget(
            self,
            action: #selector(startExercise),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func startExercise() {
        self.startExerciseAction()
    }
    
    @objc func addButtonAction() {
        addNewLexicalUnitAction()
    }
    
    func updateListOfLexicalUnits(_ newList: [LexicalUnitDataModel]) {
        self.listOfUnits = newList
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
            deleteLexicalUnitAction(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        didTapOnLexicalUnitAction(indexPath)
    }
}

extension FolderContentView {
    static let buttonEdge: CGFloat = 100
}

#Preview {
    let router = Router()
    let repo = LocalRepositoryFactory.create()
    let screenFactory = ScreenFactory(router: router, localRepository: repo)
    router.setScreenFactory(screenFactory)
    
    let folderVM = FolderContentViewModel(
        localRepository: repo,
        folderID: "",
        router: router
    )
    
    return FolderContentViewController(folderContentViewModel: folderVM)
}
