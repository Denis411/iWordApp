// FolderModel.swift
// iWord
//
// Created by Denis Ulianov on 10/8/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Foundation
import Repository

struct FolderModel {
    var listOfFolders: [FolderDataModel] = []
    
    mutating func addFolder(_ folder: FolderDataModel) {
        self.listOfFolders.append(folder)
    }
    
    mutating func deleteFolder(_ folder: FolderDataModel) {
        self.listOfFolders.removeAll { currentFolder in
            folder == currentFolder
        }
    }
    
    mutating func editFolderName(model: FolderDataModel, newName: String) {
        guard let folderToEditIndex = listOfFolders.firstIndex(where: { $0 == model }) else {
            return
        }
        
        listOfFolders[folderToEditIndex].changeName(newName)
    }
}
