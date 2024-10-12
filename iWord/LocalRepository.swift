// LocalRepository.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Foundation

typealias LocalRepositoryProtocol = FolderModelLocalRepositoryProtocol & LexicalUnitModelLocalRepositoryProtocol

protocol FolderModelLocalRepositoryProtocol {
    func fetchFolders() async throws -> [FolderDataModel]
    func deleteFolder(uuid: String) async throws
    func updateFolder(folderModel: FolderDataModel) async throws
}

protocol LexicalUnitModelLocalRepositoryProtocol {
    func fetchLexicalUnits(with folderID: String) async throws -> [LexicalUnitDataModel]
    func deleteLexicalUnit(with uuid: String) async throws
    func updateLexicalUnit(with uuid: String) async throws
}

// MARK: - I should have created a separated models for saving data in the DB
final class LocalRepository: FolderModelLocalRepositoryProtocol {
    
    func fetchFolders() async throws -> [FolderDataModel] {
        []
    }
    
    func deleteFolder(uuid: String) async throws {
        
    }
    
    func updateFolder(folderModel: FolderDataModel) async throws {
        
    }
}

extension LocalRepository: LexicalUnitModelLocalRepositoryProtocol {
    func fetchLexicalUnits(with folderID: String) async throws -> [LexicalUnitDataModel] {
        []
    }
    
    func deleteLexicalUnit(with uuid: String) async throws {
        
    }
    
    func updateLexicalUnit(with uuid: String) async throws {
        
    }
}
