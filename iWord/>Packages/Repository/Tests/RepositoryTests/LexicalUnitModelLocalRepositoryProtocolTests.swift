import Testing
import Foundation

@testable import Repository

// MARK: - Testing LexicalUnitModelLocalRepositoryProtocol

@Suite("Tests LexicalUnitModelLocalRepositoryProtocol") struct TestLexicalUnitOperations {
    
    private let folderName = "TestFolder"
    
    @Test func testSavingLexicalUnit() async throws {
        let repository = LocalRepository()
        try await repository.createEmptyFolder(with: folderName)
        let folder = await repository.data.keys.first(where: { $0.name == folderName} )
        
        try await repository.saveLexicalUnit(
            folderID: #require(folder?.id),
            originalWord: "Кот",
            mainTranslation: "Cat",
            completionPercentage: 0,
            pngImageData: nil
        )
        
        let previouslySaveLexicalUnit = try await repository.data[#require(folder)]?.first
        
        #expect(try previouslySaveLexicalUnit?.folderID == #require(folder?.id))
    }
    
    @Test func testDeletingLexicalUnit() async throws {
        let repository = LocalRepository()
        try await repository.createEmptyFolder(with: folderName)
        let folder = await repository.data.keys.first(where: { $0.name == folderName} )
        
        try await repository.saveLexicalUnit(
            folderID: #require(folder?.id),
            originalWord: "Кот",
            mainTranslation: "Cat",
            completionPercentage: 0,
            pngImageData: nil
        )
        
        let previouslySaveLexicalUnit = try await repository.data[#require(folder)]?.first
        guard let previouslySaveLexicalUnit else {
            throw TestError()
        }
        
        #expect(try previouslySaveLexicalUnit.folderID == #require(folder?.id))
        
        // Deletion
        
        try await repository.deleteLexicalUnit(
            with: previouslySaveLexicalUnit.uuid,
            with: previouslySaveLexicalUnit.folderID
        )
        
        let firstFolderKey = try #require(await repository.data.keys.first)
        let value = await repository.data[firstFolderKey]
        #expect(value == [])
    }
    
    @Test func testUpdatingLexicalUnit() async throws {
        let repository = LocalRepository()
        try await repository.createEmptyFolder(with: folderName)
        let folderId = try #require(await repository.data.keys.first?.id)
        try await repository.saveLexicalUnit(
            folderID: folderId,
            originalWord: "Dose not matter",
            mainTranslation: "Да вообще любой",
            completionPercentage: 0,
            pngImageData: nil
        )
        
        let unitId = try #require(await repository.fetchLexicalUnits(with: folderId).first?.uuid)
        
        let newLexicalUnit = LexicalUnitDataModel(
            uuid: unitId,
            folderID: folderId,
            originalWord: "Updated",
            mainTranslation: "Updated",
            completionPercentage: 0,
            pngImageData: nil
        )
        
        try await repository.updateLexicalUnit(with: unitId, with: folderId, newValue: newLexicalUnit)
        
        let updatedLexicalUnit = try #require(await repository.fetchLexicalUnits(with: folderId).first)
        
        #expect(updatedLexicalUnit.originalWord == "Updated")
    }
    
    // testing fetching of all units in a folder in not needed because it is tested the test above
}

struct TestError: Error { }
