// ScreenFactory.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import SwiftUI

final class ScreenFactory {
    // User DI here
    private var folderScreenViewModel: FolderScreenViewModel?
    private var folderContentViewModel: FolderContentViewModel?
    private let newLexicalUnitViewModel = NewLexicalUnitViewModel()
    private let cardExerciseViewModel = CardExerciseViewModel(listOfModels: [.init()])
    private var router: Router?
    
    func setRouter(router: Router?) {
        self.router = router
    }
    
    func createFolderScreen() -> some View {
        guard let router else {
            fatalError()
        }
        folderScreenViewModel = FolderScreenViewModel(router: router)
        return RouterRootView(router: router) {
            FolderScreenView(folderScreenViewModel: self.folderScreenViewModel!)
        }
    }
    
    func createFolderContentScreen(with folderID: String) -> some View {
        self.folderContentViewModel = FolderContentViewModel(with: folderID)
        return FolderContentViewControllerRepresentable(folderContentViewModel: folderContentViewModel!)
    }
    
    func createAddNewLexicalUnitScreen() -> some View {
        AddNewLexicalUnitView(viewModel: newLexicalUnitViewModel)
    }
    
    func createCardExerciseScreen() -> some View {
        CardExerciseView(cardExerciseViewModel: cardExerciseViewModel)
    }
}
