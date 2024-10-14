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
    private let router: RouterProtocol
    private let localRepository: LexicalUnitModelLocalRepositoryProtocol
    private let folderID: String
    @Published private(set) var listOfLexicalUnits: [LexicalUnitDataModel] = []
    @Published private(set) var isEmptyFolderAlertPresented: Bool = false
    
    init(
        localRepository: LocalRepositoryProtocol,
        folderID: String,
        router: Router
    ) {
        self.router = router
        self.localRepository = localRepository
        // load data for folder id
        self.folderID = folderID
        
        refreshData()
    }
    
    func deleteLexicalUnit(at indexPath: IndexPath) {
        listOfLexicalUnits.remove(at: indexPath.row)
        Task(priority: .utility) {
            try? await localRepository.deleteLexicalUnit(
                with: listOfLexicalUnits[indexPath.row].uuid,
                with: folderID
            )
        }
    }
    
    func didTapLexicalUnit(at indexPath: IndexPath) {
        
    }
    
    func openAddNewLexicalUnitScreen() {
        Task {
            await router.navigateTo(.newLexicalUnitView(folderID: folderID))
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
    
    func refreshData() {
        Task(priority: .userInitiated) {
            // Show spinner
            do {
                let updatedListOfLexicalUnits = try await localRepository.fetchLexicalUnits(with: folderID)
                await MainActor.run {
                    self.listOfLexicalUnits = updatedListOfLexicalUnits
                }
            } catch {
                // show error
            }
            // hide spinner
        }
    }
}
