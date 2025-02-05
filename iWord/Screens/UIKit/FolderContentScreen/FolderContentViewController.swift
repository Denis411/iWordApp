// FolderScreenViewController.swift
// iWord
//
// Created by Denis Ulianov on 10/8/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import UIKit
import Combine
import Repository

// Making binding in FolderContentViewControllerRepresentable might look more appropriate
// but I want to keep it here in case I have to control the lifecycle of the VC without any extra closures
final class FolderContentViewController: UIViewController {
    private let folderContentViewModel: FolderContentViewModel
    private var disposedBag = Set<AnyCancellable>()
    
    private var internalView: FolderContentView { view as! FolderContentView }
    
    init(folderContentViewModel: FolderContentViewModel) {
        self.folderContentViewModel = folderContentViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = FolderContentView()
    }
    
    func update(
        listOfUnits: [LexicalUnitDataModel],
        startExerciseAction: @escaping () -> Void,
        addNewLexicalUnitAction: @escaping () -> Void,
        deleteLexicalUnitAction: @escaping (IndexPath) -> Void,
        didTapOnLexicalUnitAction: @escaping (IndexPath) -> Void
    ) {
        internalView.updateListOfLexicalUnits(listOfUnits)
        internalView.setActions(
            startExerciseAction: startExerciseAction,
            addNewLexicalUnitAction: addNewLexicalUnitAction,
            deleteLexicalUnitAction: deleteLexicalUnitAction,
            didTapOnLexicalUnitAction: didTapOnLexicalUnitAction
        )
    }
}
