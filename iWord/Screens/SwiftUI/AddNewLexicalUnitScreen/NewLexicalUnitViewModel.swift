// NewLexicalUnitViewModel.swift
// iWord
//
// Created by Denis Ulianov on 10/11/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Foundation
import Repository

final class NewLexicalUnitViewModel: ObservableObject {
    private let folderId: String
    private let router: Router
    private let localRepository: LexicalUnitModelLocalRepositoryProtocol
    @Published var originalLexicalUnit: String = ""
    @Published var translation: String = ""
    @Published var pickedImage: Data? = nil
    
    init(
        folderId: String,
        router: Router,
        localRepository: LexicalUnitModelLocalRepositoryProtocol
    ) {
        self.folderId = folderId
        self.router = router
        self.localRepository = localRepository
    }
    
    @MainActor func nullifyPickedImage() {
        self.pickedImage = nil
    }
    
    func saveLexicalUnit() {
        guard originalLexicalUnit != "",
                translation != "" else {
            // show alert
            return
        }
        
        Task(priority: .userInitiated) {
            try? await localRepository.saveLexicalUnit(
                folderID: folderId,
                originalWord: originalLexicalUnit,
                mainTranslation: translation,
                completionPercentage: 0,
                pngImageData: pickedImage
            )
            
            await router.navigateBack()
        }
    }
}
