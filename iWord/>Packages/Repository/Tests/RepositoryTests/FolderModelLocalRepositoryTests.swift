import Testing
@testable import Repository

@Suite("Tests FolderModelLocalRepositoryProtocol")
struct FolderModelLocalRepositoryTests {
    
    @Test func testSavingFolder() async throws {
        let repository: FolderModelLocalRepositoryProtocol = LocalRepository()
        let folderName = "TestName"
        try await repository.createEmptyFolder(with: folderName)
        
        let allFolders = try await repository.fetchFolders()
        let firstFolder = allFolders.first
        
        #expect(firstFolder?.name == folderName)
    }
    
    @Test func testFetchingAllFolders() async throws {
        let repository: FolderModelLocalRepositoryProtocol = LocalRepository()
        let numOfFolders = 10
        
        for i in 0..<numOfFolders {
            try await repository.createEmptyFolder(with: "Folder \(i)")
        }
        
        let allFolders = try #require(await repository.fetchFolders())
        #expect(allFolders.count == numOfFolders)
    }
    
    @Test func testDeletingFolder() async throws {
        let repository: FolderModelLocalRepositoryProtocol = LocalRepository()
        let folderName = "TestName"
        try await repository.createEmptyFolder(with: folderName)
        let allFolders = try #require(await repository.fetchFolders())
        let firstFolder = try #require(allFolders.first)
        let uuidToDelete = try #require(firstFolder.id)
        
        try await repository.deleteFolder(uuid: uuidToDelete)
        
        await #expect(try repository.fetchFolders().isEmpty)
    }
    
    @Test func testUpdatingFolder() async throws {
        let repository: FolderModelLocalRepositoryProtocol = LocalRepository()
        // save folder first
        let folderName = "FolderName"
        try #require(await repository.createEmptyFolder(with: folderName))
        // fetch folder to get id
        let allFolders = try #require(await repository.fetchFolders())
        let folderID = try #require(allFolders.first?.id)
        
        let updatedFolderName = "UpdatedFolderName"
        let newFolder = FolderDataModel(
            id: folderID,
            name: updatedFolderName,
            numberOfWords: 200
        )
        
        try #require(await repository.updateFolder(folderModel: newFolder))
        
        let allFoldersAfterUpdate = try #require(await repository.fetchFolders())
        let firstFolderModel = try #require(allFoldersAfterUpdate.first)
        
        #expect(firstFolderModel.name == updatedFolderName)
        #expect(firstFolderModel.numberOfWords == 200)
        #expect(firstFolderModel.id == folderID)
    }
    
}
