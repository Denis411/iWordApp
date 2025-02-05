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

public struct LexicalUnitDataModel: Hashable, Sendable {
    public let uuid: String
    public let folderID: String
    public let originalWord: String
    public let mainTranslation: String
    public var completionPercentage: UInt8
    public let pngImageData: Data?
    
    init(
        uuid: String,
        folderID: String,
        originalWord: String,
        mainTranslation: String,
        completionPercentage: UInt8,
        pngImageData: Data?
    ) {
        self.uuid = uuid
        self.folderID = folderID
        self.originalWord = originalWord
        self.mainTranslation = mainTranslation
        self.completionPercentage = completionPercentage
        self.pngImageData = pngImageData
    }
    
    public mutating func increasePercentage(by percent: UInt8) {
        completionPercentage += percent
    }
    
    public mutating func decreasePercentage(by percent: UInt8) {
        guard completionPercentage > 0 else {
            // unsigned Ints can be overflowed
            return
        }
        completionPercentage -= percent
    }
}

extension LexicalUnitDataModel: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.uuid == rhs.uuid &&
        lhs.folderID == rhs.folderID &&
        lhs.originalWord == rhs.originalWord &&
        lhs.mainTranslation == rhs.mainTranslation &&
        lhs.completionPercentage == rhs.completionPercentage &&
        lhs.pngImageData == rhs.pngImageData
    }
}

// FIXME: - create debug schema
public extension LexicalUnitDataModel {
    static func previewMock() -> Self {
        LexicalUnitDataModel(
            uuid: UUID().uuidString,
            folderID: "Mock folder",
            originalWord: "Cat",
            mainTranslation: "Кот",
            completionPercentage: UInt8.random(in: 0...100),
            pngImageData:  UIImage(named: "KittyCat")?.pngData()
        )
    }
}
