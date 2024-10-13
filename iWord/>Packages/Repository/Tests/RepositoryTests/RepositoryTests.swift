import Testing
@testable import Repository

@Test func testSavingFolder() async throws {
    let repository: LocalRepositoryProtocol = LocalRepository()
    let folderName = "TestName"
    try await repository.createEmptyFolder(with: folderName)
    
    let allFolders = try await repository.fetchFolders()
    let firstFolder = allFolders.first
    
    #expect(firstFolder?.name == folderName)
}
