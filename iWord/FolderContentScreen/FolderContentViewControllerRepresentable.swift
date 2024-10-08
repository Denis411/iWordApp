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

struct FolderContentViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FolderContentViewController {
        FolderContentViewController()
    }
    
    func updateUIViewController(_ uiViewController: FolderContentViewController, context: Context) {
    }
}
