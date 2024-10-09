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
    private let folderScreenViewModel = FolderScreenViewModel()
    private let percentageView1: PercentView = {
        let view = PercentView()
        view.updatePercentage(180)
        return view
    }()
    private let percentageView2: PercentView = {
        let view = PercentView()
        view.updatePercentage(80)
        return view
    }()
    var body: some Scene {
        WindowGroup {
//            FolderScreen(folderScreenViewModel: folderScreenViewModel)
            FolderContentViewControllerRepresentable()
//            percentageView1
//                .frame(width: 100, height: 100)
//            percentageView2
//                .frame(width: 100, height: 100)
        }
    }
}
