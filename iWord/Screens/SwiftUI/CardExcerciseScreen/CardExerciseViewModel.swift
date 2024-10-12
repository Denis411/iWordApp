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

final class CardExerciseViewModel: ObservableObject {
    private var listOfModels: [LexicalUnit]
    @Published private(set) var currentModel: LexicalUnit
    @Published private(set) var isExerciseCompleted: Bool = false
    private var currentIndex: Int = 0
    
    init(listOfModels: [LexicalUnit]) {
        if listOfModels.count == 0 {
            assertionFailure()
        }
        
        self.listOfModels = listOfModels
        self.currentModel = listOfModels[0]
    }
    
    // User knows the word
    func reactPositively () {
        guard currentIndex < listOfModels.count else {
            assertionFailure()
            return
        }
        listOfModels[currentIndex].increasePercentage(by: 1)
        
        currentIndex += 1
        
        if currentIndex >= listOfModels.count {
            isExerciseCompleted = true
            return
        }
        
        currentModel = listOfModels[currentIndex]
    }
    
    // User does not know the word
    func reactNegatively() {
        guard currentIndex < listOfModels.count,
        isExerciseCompleted != true else {
            assertionFailure()
            return
        }
        
        listOfModels[currentIndex].decreasePercentage(by: 1)
        
        currentIndex += 1
        
        if currentIndex >= listOfModels.count {
            isExerciseCompleted = true
            return
        }
        currentModel = listOfModels[currentIndex]
    }
    
    func closeExercise() {
        
    }
}
