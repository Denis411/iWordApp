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

final class FolderContentViewModel: ObservableObject {
    @Published private(set) var listOfUnits: [LexicalUnit]
    
    init(listOfUnits: [LexicalUnit]) {
        self.listOfUnits = listOfUnits
    }
    
    func deleteLexicalUnit(at indexPath: IndexPath) {
        listOfUnits.remove(at: indexPath.row)
    }
    
    func didTapLexicalUnit(at indexPath: IndexPath) {
        
    }
    
    func openAddNewLexicalUnitScreen() {
        listOfUnits.append(.init())
    }
}
