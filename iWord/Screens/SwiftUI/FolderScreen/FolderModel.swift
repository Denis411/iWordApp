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

struct FolderModel {
    var listOfFolders: [Folder] = []
    
    mutating func addFolder(_ folder: Folder) {
        self.listOfFolders.append(folder)
    }
    
    mutating func deleteFolder(_ folder: Folder) {
        self.listOfFolders.removeAll { currentFolder in
            folder == currentFolder
        }
    }
    
    mutating func editFolderName(model: Folder, newName: String) {
        guard let folderToEditIndex = listOfFolders.firstIndex(where: { $0 == model }) else {
            return
        }
        
        listOfFolders[folderToEditIndex].name = newName
    }
}

extension FolderModel {
    struct Folder: Identifiable, Equatable {
        var id = UUID().uuidString
        var name: String
        var numberOfWords: String
        
        init(id: String = UUID().uuidString, name: String, numberOfWords: String) {
            self.id = id
            self.name = name
            self.numberOfWords = numberOfWords
        }
    }
}
