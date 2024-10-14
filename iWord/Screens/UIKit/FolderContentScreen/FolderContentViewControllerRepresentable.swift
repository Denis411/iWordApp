// FolderContentViewControllerRepresentable.swift
// iWord
//
// Created by Denis Ulianov on 10/8/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import SwiftUI

// Used purely for alert purposes
// because it is difficult to implement a SwiftUI alert in a UIViewControllerRepresentable
// a god idea would be to relocate alert logic to router
struct FolderContentSwiftUIContainerView: View {
    @ObservedObject private var folderContentViewModel: FolderContentViewModel
    
    init(folderContentViewModel: FolderContentViewModel) {
        self.folderContentViewModel = folderContentViewModel
    }
    
    var body: some View {
        FolderContentViewControllerRepresentable(folderContentViewModel: folderContentViewModel)
            .onAppear {
                folderContentViewModel.refreshData()
            }
            .alert(
                "You do not have lexical units in this folder to exercise with.",
                isPresented: Binding(
                    get: {
                        folderContentViewModel.isEmptyFolderAlertPresented
                    },
                    set: { newValue in
                        folderContentViewModel.setEmptyFolderAlert(isPresented: newValue)
                    }
                )
            ) {
                Button("Ok", role: .cancel) { }
            }
    }
}

private struct FolderContentViewControllerRepresentable: UIViewControllerRepresentable {
    @ObservedObject private var folderContentViewModel: FolderContentViewModel
    
    init(folderContentViewModel: FolderContentViewModel) {
        self.folderContentViewModel = folderContentViewModel
    }
    
    func makeUIViewController(context: Context) -> FolderContentViewController {
        FolderContentViewController(folderContentViewModel: folderContentViewModel)
    }
    
    func updateUIViewController(_ uiViewController: FolderContentViewController, context: Context) {
        print("Updated")
    }
}


