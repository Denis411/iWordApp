// CardExerciseViewModel.swift
// iWord
//
// Created by Denis Ulianov on 10/11/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Combine
import Repository

final class CardExerciseViewModel: ObservableObject {
    private let localRepository: LexicalUnitModelLocalRepositoryProtocol
    private var listOfLexicalUnits: [LexicalUnitDataModel]
    @Published private(set) var currentModel: LexicalUnitDataModel
    @Published private(set) var isExerciseCompleted: Bool = false
    private var currentIndex: Int = 0
    
    init(
        with listOfLexicalUnits: [LexicalUnitDataModel],
        localRepository: LexicalUnitModelLocalRepositoryProtocol
    ) {
        if listOfLexicalUnits.count == 0 {
            assertionFailure()
        }
        
        self.localRepository = localRepository
        self.listOfLexicalUnits = listOfLexicalUnits
        self.currentModel = listOfLexicalUnits[0]
    }
    
    // User knows the word
    func reactPositively () {
        guard currentIndex < listOfLexicalUnits.count else {
            assertionFailure()
            return
        }
        
        updateCurrentLexicalUnit()
        
        currentIndex += 1
        
        if currentIndex >= listOfLexicalUnits.count {
            isExerciseCompleted = true
            return
        }
        
        currentModel = listOfLexicalUnits[currentIndex]
    }
    
    // User does not know the word
    func reactNegatively() {
        guard currentIndex < listOfLexicalUnits.count,
        isExerciseCompleted != true else {
            assertionFailure()
            return
        }
        
        updateCurrentLexicalUnit()
        
        currentIndex += 1
        
        if currentIndex >= listOfLexicalUnits.count {
            isExerciseCompleted = true
            return
        }
        currentModel = listOfLexicalUnits[currentIndex]
    }
    
    private func updateCurrentLexicalUnit() {
        var currentLexicalUnit = listOfLexicalUnits[currentIndex]
        currentLexicalUnit.decreasePercentage(by: 1)
        Task {
            do {
                try await localRepository.updateLexicalUnit(
                    with: currentLexicalUnit.uuid,
                    with: currentLexicalUnit.folderID,
                    newValue: currentLexicalUnit
                )
            } catch {
                // handle error
                assertionFailure()
            }
        }
        currentIndex += 1
    }
    
    func closeExercise() {
        
    }
}
