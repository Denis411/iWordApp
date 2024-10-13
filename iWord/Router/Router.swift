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
    private weak var screenFactory: ScreenFactory?
    @Published var path: NavigationPath = NavigationPath()
    
    // Builds the views
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .folderContentView(let listOfLexicalUnits):
            screenFactory?.createFolderContentScreen(listOfLexicalUnits: listOfLexicalUnits)
        case .newLexicalUnitView:
            screenFactory?.createAddNewLexicalUnitScreen()
        case .cardExerciseView(let listOfLexicalUnits):
            screenFactory?.createCardExerciseScreen(with: listOfLexicalUnits)
        }
    }
    
    func setScreenFactory(_ factory: ScreenFactory) {
        self.screenFactory = factory
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
