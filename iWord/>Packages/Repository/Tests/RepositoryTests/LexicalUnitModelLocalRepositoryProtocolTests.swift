import Testing
import Foundation

@testable import Repository

// MARK: - Testing LexicalUnitModelLocalRepositoryProtocol

@Suite() struct TestLexicalUnitOperations {
    
    @Test func testSavingLexicalUnit() async throws {
        let repository = LocalRepository()
        let folderName = "TestFolder"
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
        let folderName = "TestFolder"
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
    
}

struct TestError: Error { }
