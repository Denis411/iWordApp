// LexicalUnit.swift
// iWord
//
// Created by Denis Ulianov on 10/8/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Foundation
// TODO: - Remove UIKit
import UIKit

struct LexicalUnitDataModel: Hashable {
    private let uuid = UUID().uuidString
    let folderID: String
    let originalWord: String
    let mainTranslation: String
    var completionPercentage: UInt8
    let pngImageData: Data?
    
    init() {
        self.folderID = "Mock folder"
        self.originalWord = "Cat"
        self.mainTranslation = "Кот"
        self.completionPercentage = UInt8.random(in: 99...100)
        self.pngImageData = UIImage(named: "KittyCat")?.pngData()
    }
    
    mutating func increasePercentage(by percent: UInt8) {
        completionPercentage += percent
    }
    
    mutating func decreasePercentage(by percent: UInt8) {
        completionPercentage -= percent
    }
}

extension LexicalUnitDataModel: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
