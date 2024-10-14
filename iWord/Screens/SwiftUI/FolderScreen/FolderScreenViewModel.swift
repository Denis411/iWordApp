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
import Foundation

final class FolderScreenViewModel: ObservableObject {
    private let router: RouterProtocol
    private let localRepository: LocalRepositoryProtocol
    
    @Published private(set) var folderModel: FolderModel? = nil
    private(set) var folderToDelete: FolderDataModel? = nil
    private(set) var folderToEdit: FolderDataModel? = nil
    
    init(
        router: RouterProtocol,
        localRepository: LocalRepositoryProtocol
    ) {
        self.router = router
        self.localRepository = localRepository
        
        Task(priority: .userInitiated) {
            // show spinner
            do {
                let previouslySavedFolders = try await self.localRepository.fetchFolders()
                folderModel = FolderModel(listOfFolders: previouslySavedFolders)
            } catch { }
            // hide spinner
        }
    }
    
    func addFolder(with name: String) {
        let folderUUID = UUID().uuidString
        print(folderUUID)
        let newFolderModel = FolderDataModel(
            id: folderUUID,
            name: name,
            numberOfWords: 0
        )
        folderModel?.addFolder(newFolderModel)
        Task(priority: .utility) {
            do {
                try await localRepository.createEmptyFolder(
                    with: name,
                    uuid: folderUUID
                )
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
        folderModel?.deleteFolder(folderToDelete)
        Task {
            do {
                try await localRepository.deleteFolder(uuid: folderToDelete.id)
            } catch {
                // show alert
            }
            self.folderToDelete = nil
        }
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
        self.folderModel?.editFolderName(model: folderToEdit, newName: name)
        
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
        print(folderID)
        Task(priority: .userInitiated) {
            let lexicalUnits = try? await localRepository.fetchLexicalUnits(with: folderID)
            await router.navigateTo(
                .folderContentView(
                    listOfLexicalUnits: lexicalUnits ?? [],
                    folderID: folderID
                )
            )
        }
    }
    
    func refetchData() {
        Task {
            // show spinner
            do {
                let listOfFolders = try await localRepository.fetchFolders()
                await MainActor.run {
                    folderModel?.updateListOfFolders(listOfFolders)
                }
            } catch {
            // show alert
            }
            // hide spinner
        }
    }
}
