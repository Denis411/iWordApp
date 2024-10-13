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

public typealias LocalRepositoryProtocol = FolderModelLocalRepositoryProtocol & LexicalUnitModelLocalRepositoryProtocol

public protocol FolderModelLocalRepositoryProtocol {
    func fetchFolders() async throws -> [FolderDataModel]
    func deleteFolder(uuid: String) async throws
    func updateFolder(folderModel: FolderDataModel) async throws
}

public protocol LexicalUnitModelLocalRepositoryProtocol {
    func fetchLexicalUnits(with folderID: String) async throws -> [LexicalUnitDataModel]
    func deleteLexicalUnit(with uuid: String, with folderID: String) async throws
    func updateLexicalUnit(with uuid: String, with folderID: String, newValue: LexicalUnitDataModel) async throws
}
