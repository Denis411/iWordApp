// FolderContentViewModel.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Foundation
import Repository

final class FolderContentViewModel: ObservableObject {
    private let folderID: String
    private let router: RouterProtocol
    @Published private(set) var listOfLexicalUnits: [LexicalUnitDataModel]
    @Published private(set) var isEmptyFolderAlertPresented: Bool = false
    
    init(
        with folderID: String,
        router: Router
    ) {
        self.folderID = folderID
        self.router = router
        // load data for folder id
        self.listOfLexicalUnits = []
    }
    
    func deleteLexicalUnit(at indexPath: IndexPath) {
        listOfLexicalUnits.remove(at: indexPath.row)
    }
    
    func didTapLexicalUnit(at indexPath: IndexPath) {
        
    }
    
    func openAddNewLexicalUnitScreen() {
        Task {
            await router.navigateTo(.newLexicalUnitView)
        }
    }
    
    func openCardExerciseScreen() {
        guard listOfLexicalUnits.count > 0 else {
            isEmptyFolderAlertPresented = true
            self.objectWillChange.send()
            return
        }
        Task {
            await router.navigateTo(.cardExerciseView(listOfLexicalUnits: listOfLexicalUnits))
        }
    }
    
    func setEmptyFolderAlert(isPresented: Bool) {
        self.isEmptyFolderAlertPresented = isPresented
    }
}
