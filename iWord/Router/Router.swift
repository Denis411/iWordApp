// Router.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org

import SwiftUI

@MainActor protocol RouterProtocol {
    func navigateTo(_ appRoute: Route)
    func navigateBack()
    func popToRoot()
}

final class Router: ObservableObject {
    private let screenFactory: ScreenFactory
    @Published var path: NavigationPath = NavigationPath()
    
    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }
    // Builds the views
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .folderContentView(let folderID):
            screenFactory.createFolderContentScreen(with: folderID)
        case .newLexicalUnitView:
            screenFactory.createAddNewLexicalUnitScreen()
        case .cardExerciseView(let listOfLexicalUnits):
            screenFactory.createCardExerciseScreen(with: listOfLexicalUnits)
        }
    }
    
}

extension Router: RouterProtocol {
    // Used by views to navigate to another view
    @MainActor
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    // Used to go back to the previous screen
    @MainActor
    func navigateBack() {
        path.removeLast()
    }
    
    // Pop to the root screen in our hierarchy
    @MainActor
    func popToRoot() {
        path.removeLast(path.count)
    }
}
