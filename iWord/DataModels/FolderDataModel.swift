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

struct FolderDataModel: Identifiable{
    let id: String
    private(set) var name: String
    private(set) var numberOfWords: Int
    
    mutating func changeName(_ newName: String) {
        self.name = newName
    }
    
    mutating func changeNumberOfWords(_ newNumber: Int) {
        self.numberOfWords = newNumber
    }
    
    init(
        id: String = UUID().uuidString,
        name: String,
        numberOfWords: Int
    ) {
        self.id = id
        self.name = name
        self.numberOfWords = numberOfWords
    }
}

extension FolderDataModel: Equatable, Hashable  {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
