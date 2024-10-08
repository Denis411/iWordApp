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

final class FolderScreenViewModel: ObservableObject {
    @Published private(set) var folderModel: FolderModel = FolderModel()
    private(set) var folderToDelete: FolderModel.Folder? = nil
    private(set) var folderToEdit: FolderModel.Folder? = nil
    
    func addFolder(with name: String) {
        let newFolderModel = FolderModel.Folder(name: name, numberOfWords: "")
        folderModel.addFolder(newFolderModel)
    }
    
    
    // set folder before deleting
    // this wired way is used because of SwiftUI alert limitations
    func setFolderToDelete(_ model: FolderModel.Folder) {
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
    func setFolderToEdit(_ model: FolderModel.Folder) {
        self.folderToEdit = model
    }
    
    func setNewNameForFolder(name: String) {
        guard let folderToEdit else {
            assertionFailure()
            return
        }
        self.folderModel.editFolderName(model: folderToEdit, newName: name)
    }
}
