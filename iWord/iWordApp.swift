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

@main
struct iWordApp: App {
    private let router: Router
    private let screenFactory: ScreenFactory
    
    init() {
        self.screenFactory = ScreenFactory()
        self.router = Router(screenFactory: screenFactory)
        screenFactory.setRouter(router: router)
    }
    
    var body: some Scene {
        WindowGroup {
            screenFactory.createFolderScreen()
        }
    }
}
