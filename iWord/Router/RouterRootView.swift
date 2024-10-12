// RouterView.swift
// iWord
//
// Created by Denis Ulianov on 10/12/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import SwiftUI

struct RouterRootView<Content: View>: View {
    @StateObject private var router: Router
    private let rootView: Content
    
    init(
        router: Router,
        @ViewBuilder rootView: @escaping () -> Content
    ) {
        _router = StateObject(wrappedValue: router)
        self.rootView = rootView()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            rootView
                .navigationDestination(for: Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}
