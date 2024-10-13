// iWordApp.swift
// iWord
//
// Created by Denis Ulianov on 10/7/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org

import SwiftUI
import Repository

@main
struct iWordApp: App {
    // Create DI
    private let router: Router
    private let screenFactory: ScreenFactory
    private let localRepository: LocalRepositoryProtocol
    
    init() {
        self.router = Router()
        self.localRepository = LocalRepositoryFactory.create()
        self.screenFactory = ScreenFactory(router: router, localRepository: localRepository)
        
        self.router.setScreenFactory(screenFactory)
    }
    
    var body: some Scene {
        WindowGroup {
            screenFactory.createFolderScreen()
        }
    }
}
