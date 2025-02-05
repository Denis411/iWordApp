// Route.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import Foundation
import Repository

// Contains the possible destinations in our Router
// Data between views will be passed through repository
enum Route: Hashable {
    case folderContentView(listOfLexicalUnits: [LexicalUnitDataModel], folderID: String)
    case newLexicalUnitView(folderID: String)
    case cardExerciseView(listOfLexicalUnits: [LexicalUnitDataModel])
}
