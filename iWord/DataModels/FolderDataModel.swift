// Folder.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Foundation

struct FolderDataModel: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var numberOfWords: String
    
    init(id: String = UUID().uuidString, name: String, numberOfWords: String) {
        self.id = id
        self.name = name
        self.numberOfWords = numberOfWords
    }
}
