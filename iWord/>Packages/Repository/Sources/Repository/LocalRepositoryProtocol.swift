// LocalRepositoryProtocol.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org

import Foundation

public typealias lexicalUnitUUID = String
public typealias FolderID = String

public typealias LocalRepositoryProtocol = FolderModelLocalRepositoryProtocol & LexicalUnitModelLocalRepositoryProtocol

public protocol FolderModelLocalRepositoryProtocol {
    func createEmptyFolder(with name: String) async throws 
    func fetchFolders() async throws -> [FolderDataModel]
    func deleteFolder(uuid: FolderID) async throws
    func updateFolder(folderModel: FolderDataModel) async throws
}

public protocol LexicalUnitModelLocalRepositoryProtocol {
    func saveLexicalUnit(
        folderID: FolderID,
        originalWord: String,
        mainTranslation: String,
        completionPercentage: UInt8,
        pngImageData: Data?
    ) async throws
    func fetchLexicalUnits(with folderID: FolderID) async throws -> [LexicalUnitDataModel]
    func deleteLexicalUnit(with uuid: lexicalUnitUUID, with folderID: FolderID) async throws
    func updateLexicalUnit(with uuid: lexicalUnitUUID, with folderID: FolderID, newValue: LexicalUnitDataModel) async throws
}
