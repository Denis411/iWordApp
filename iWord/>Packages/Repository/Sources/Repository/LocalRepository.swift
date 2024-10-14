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

// MARK: - I should have created a separated models for saving data in the DB
// Базы данных нет, но вы держитесь
actor LocalRepository: FolderModelLocalRepositoryProtocol {
    internal var data: [FolderDataModel: [LexicalUnitDataModel]]
    
    internal init() {
        // load data from a real DB
        self.data = [:]
    }
    
    deinit {
        // safe cashed changes in a thread safe manner
    }
    
    func createEmptyFolder(with name: String, uuid: String) async throws {
        let folderModel = FolderDataModel(
            id: uuid,
            name: name,
            numberOfWords: 0
        )
        data[folderModel] = .some([])
    }
    
    func fetchFolders() async throws -> [FolderDataModel] {
         Array(data.keys)
    }
    
    func deleteFolder(uuid: String) async throws {
        let keyWithUUID = data.first { key, _ in
            key.id == uuid
        }?.key
        
        if let keyWithUUID {
            data[keyWithUUID] = nil
        } else {
            assertionFailure("Folder with the given key dose not exist")
            throw LocalRepositoryError.keyDoseNotExist
        }
    }
    
    func updateFolder(folderModel: FolderDataModel) async throws {
        guard let oldValue = data[folderModel] else {
            throw LocalRepositoryError.keyDoseNotExist
        }
        
        data[folderModel] = nil
        data[folderModel] = oldValue
    }
}

extension LocalRepository: LexicalUnitModelLocalRepositoryProtocol {
    func saveLexicalUnit(
        folderID: String,
        originalWord: String,
        mainTranslation: String,
        completionPercentage: UInt8,
        pngImageData: Data?
    ) async throws {
        let newLexicalUnit = LexicalUnitDataModel(
            uuid: UUID().uuidString,
            folderID: folderID,
            originalWord: originalWord,
            mainTranslation: mainTranslation,
            completionPercentage: completionPercentage,
            pngImageData: pngImageData
        )
        guard let oldKey = data.keys.first(where: { $0.id == folderID }) else {
            throw LocalRepositoryError.keyDoseNotExist
        }
        
        let oldValue = data[oldKey]
        var newValue = oldValue
        newValue?.append(newLexicalUnit)
        
        var newKey = oldKey
        newKey.increaseNumberOfWordsByOne()
        
        data[oldKey] = nil
        data[newKey] = newValue
    }
    
    func fetchLexicalUnits(with folderID: FolderID) async throws -> [LexicalUnitDataModel] {
       let dictionaryKey = data.keys.first { folderModel in
            folderModel.id == folderID
        }
        
        guard let dictionaryKey else {
            throw LocalRepositoryError.keyDoseNotExist
        }
        
        let lexicalUnits = data[dictionaryKey]
        
        return lexicalUnits ?? []
    }
    
    func deleteLexicalUnit(with uuid: lexicalUnitUUID, with folderID: FolderID) async throws {
        guard let folderKey = data.keys.first(where: { $0.id == folderID }) else {
            throw LocalRepositoryError.keyDoseNotExist
        }
        
        guard var oldValue = data[folderKey] else {
            throw LocalRepositoryError.keyDoseNotExist
        }
        
        oldValue.removeAll(where: { lexicalUnitModel in
            lexicalUnitModel.uuid == uuid
        })
        
        data.updateValue(oldValue, forKey: folderKey)
    }
    
    func updateLexicalUnit(with uuid: lexicalUnitUUID, with folderID: FolderID, newValue: LexicalUnitDataModel) async throws {
        
        guard let dictionaryKey = data.keys.first(where: { $0.id == folderID }) else {
            throw LocalRepositoryError.keyDoseNotExist
        }
        
        data[dictionaryKey]?.removeAll(where: { $0.uuid == uuid})
        data[dictionaryKey]?.append(newValue)
    }
}

enum LocalRepositoryError: Error {
    case keyDoseNotExist
}
