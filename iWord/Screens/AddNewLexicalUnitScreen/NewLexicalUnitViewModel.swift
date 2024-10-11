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

final class NewLexicalUnitViewModel: ObservableObject {
    @Published var originalLexicalUnit: String = ""
    @Published var translation: String = ""
    @Published var pickedImage: Data? = nil
    
    @MainActor func nullifyPickedImage() {
        self.pickedImage = nil
    }
    
    func saveLexicalUnit() {
        
    }
}
