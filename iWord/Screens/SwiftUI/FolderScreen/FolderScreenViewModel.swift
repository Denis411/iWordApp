// FolderScreenViewModel.swift
// iWord
//
// Created by Denis Ulianov on 10/8/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Combine
import Repository

final class FolderScreenViewModel: ObservableObject {
    private let router: RouterProtocol
    private let localRepository: LocalRepositoryProtocol
    
    @Published private(set) var folderModel: FolderModel
    private(set) var folderToDelete: FolderDataModel? = nil
    private(set) var folderToEdit: FolderDataModel? = nil
    
    init(
        router: RouterProtocol,
        localRepository: LocalRepositoryProtocol,
        initialFolders: [FolderDataModel]
    ) {
        self.router = router
        self.localRepository = localRepository
        self.folderModel = FolderModel(listOfFolders: initialFolders)
        
        Task(priority: .userInitiated) {
            // show spinner
            do {
                let previouslySavedFolders = try await self.localRepository.fetchFolders()
                folderModel.updateListOfFolders(previouslySavedFolders)
            } catch { }
            // hide spinner
        }
    }
    
    func addFolder(with name: String) {
        let newFolderModel = FolderDataModel(name: name, numberOfWords: 0)
        folderModel.addFolder(newFolderModel)
        Task(priority: .utility) {
            do {
                try await localRepository.createEmptyFolder(with: name)
            } catch {
                // handle error
            }
        }
    }
    
    // set folder before deleting
    // this wired way is used because of SwiftUI alert limitations
    func setFolderToDelete(_ model: FolderDataModel) {
        folderToDelete = model
    }
    
    func deleteFolder() {
        guard let folderToDelete else {
            assertionFailure()
            return
        }
        folderModel.deleteFolder(folderToDelete)
        self.folderToDelete = nil
    }
    
    // set folder before deleting
    // this wired way is used because of SwiftUI alert limitations
    func setFolderToEdit(_ model: FolderDataModel) {
        self.folderToEdit = model
    }
    
    func setNewNameForFolder(name: String) {
        guard var folderToEdit else {
            assertionFailure()
            return
        }
        
        // FIXME: - You do not need to use a new name here, just update the folderToEdit
        self.folderModel.editFolderName(model: folderToEdit, newName: name)
        
        Task(priority: .utility) {
            do {
                folderToEdit.changeName(name)
                try await localRepository.updateFolder(folderModel: folderToEdit)
            } catch {
                // show error alert
            }
        }
    }
    
    func openFolderContent(folderID: String) {
        Task(priority: .userInitiated) {
            let lexicalUnits = try? await localRepository.fetchLexicalUnits(with: folderID)
            await router.navigateTo(.folderContentView(listOfLexicalUnits: lexicalUnits ?? []))
        }
    }
}
