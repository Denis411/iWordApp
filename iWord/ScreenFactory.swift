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
    private var newLexicalUnitViewModel: NewLexicalUnitViewModel?
    private var cardExerciseViewModel: CardExerciseViewModel?
    
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
        self.folderContentViewModel = FolderContentViewModel(
            with: folderID,
            router: router!
        )
        return FolderContentSwiftUIContainerView(folderContentViewModel: folderContentViewModel!)
    }
    
    func createAddNewLexicalUnitScreen() -> some View {
        self.newLexicalUnitViewModel = NewLexicalUnitViewModel()
        return AddNewLexicalUnitView(viewModel: newLexicalUnitViewModel!)
    }
    
    func createCardExerciseScreen(with listOfLexicalUnits: [LexicalUnitDataModel]) -> some View {
        self.cardExerciseViewModel = CardExerciseViewModel(with: listOfLexicalUnits)
        return CardExerciseView(cardExerciseViewModel: cardExerciseViewModel!)
    }
}
