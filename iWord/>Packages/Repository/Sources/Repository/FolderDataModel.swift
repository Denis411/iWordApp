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

public struct FolderDataModel: Identifiable, Sendable {
    public let id: String
    public private(set) var name: String
    public private(set) var numberOfWords: Int
    
    public mutating func changeName(_ newName: String) {
        self.name = newName
    }
    
    public mutating func changeNumberOfWords(_ newNumber: Int) {
        self.numberOfWords = newNumber
    }
    
    public mutating func increaseNumberOfWordsByOne() {
        self.numberOfWords += 1
    }
    
    public init(
        id: String,
        name: String,
        numberOfWords: Int
    ) {
        self.id = id
        self.name = name
        self.numberOfWords = numberOfWords
    }
}

extension FolderDataModel: Equatable, Hashable  {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.name)
        hasher.combine(self.numberOfWords)
    }
}
