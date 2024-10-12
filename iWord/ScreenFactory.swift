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
    private let folderScreenViewModel = FolderScreenViewModel()
    private let folderContentViewModel = FolderContentViewModel(listOfUnits: [])
    private let newLexicalUnitViewModel = NewLexicalUnitViewModel()
    private let cardExerciseViewModel = CardExerciseViewModel(listOfModels: [])
    
    func createFolderScreen() -> some View {
        FolderScreenView(folderScreenViewModel: folderScreenViewModel)
    }
    
    func createFolderContentScreen() -> some View {
        FolderContentViewControllerRepresentable(folderContentViewModel: folderContentViewModel)
    }
    
    func createAddNewLexicalUnitScreen() -> some View {
        AddNewLexicalUnitView(viewModel: newLexicalUnitViewModel)
    }
    
    func createCardExerciseScreen() -> some View {
        CardExerciseView(cardExerciseViewModel: cardExerciseViewModel)
    }
}
