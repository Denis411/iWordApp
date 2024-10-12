// FolderScreen.swift
// iWord
//
// Created by Denis Ulianov on 10/7/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org

import SwiftUI

struct FolderScreenView: View {
    @ObservedObject var folderScreenViewModel: FolderScreenViewModel
    @State var newFolderName: String = ""
    @State var isNewFolderAlertPresented: Bool = false
    
    @State var isDeleteAlertShown: Bool = false
    @State var isEditAlertShown: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            createContentView()
                .animation(.easeInOut, value: folderScreenViewModel.folderModel.listOfFolders)
                .scrollIndicators(.never)
            AddButton(action: isNewFolderAlertPresented = true)
                .frame(
                    width: Self.addButtonWidth,
                    height: Self.addButtonWidth
                )
                .offset(x: -Self.addButtonOffset)
        }
        .alert(
            "Are you sure you want to delete the folder?",
            isPresented: $isDeleteAlertShown
        ) {
            Button("Cancel", role: .cancel) { }
            Button("Yes", role: .none) {
                folderScreenViewModel.deleteFolder()
            }
        }
        .alert(
            "Edit folder name",
            isPresented: $isEditAlertShown
        ) {
            TextField("\(folderScreenViewModel.folderToEdit?.name ?? "")", text: $newFolderName)
            Button("OK", role: .cancel) {
                folderScreenViewModel.setNewNameForFolder(name: newFolderName)
                newFolderName = ""
                isNewFolderAlertPresented = false
            }
        }
        .alert(
            "Enter new folder name",
            isPresented: $isNewFolderAlertPresented
        ) {
            TextField("Folder", text: $newFolderName)
            Button("OK", role: .cancel) {
                folderScreenViewModel.addFolder(with: newFolderName)
                newFolderName = ""
                isNewFolderAlertPresented = false
            }
        }
    }
}

// MARK: - Subviews
private extension FolderScreenView {
    @ViewBuilder
    func createContentView() -> some View {
            List {
                ForEach(folderScreenViewModel.folderModel.listOfFolders) { folderModel in
                    FolderCell(
                        folderModel,
                        editAction: editFolder,
                        deleteAction: deleteFolder
                    )
                    .onTapGesture {
                        handleOnFolderTap(folderModel)
                    }
                }
                .listRowSeparator(.hidden)
                .shadow(radius: 7)
            }
            .listStyle(.inset)
        .overlay {
            if folderScreenViewModel.folderModel.listOfFolders.isEmpty {
                Text("Press the plus button to create a folder")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                    .padding(.horizontal, 50)
            }
        }
    }
}

private extension FolderScreenView {
    func deleteFolder(_ model: FolderModel.Folder) {
        folderScreenViewModel.setFolderToDelete(model)
        isDeleteAlertShown = true
    }
    
    func editFolder(_ model: FolderModel.Folder) {
        folderScreenViewModel.setFolderToEdit(model)
        isEditAlertShown = true
    }
    
    func handleOnFolderTap(_ model: FolderModel.Folder) {
        folderScreenViewModel.openFolderContent(folderUUID: model.id)
    }
}

fileprivate extension FolderScreenView {
    static let addButtonWidth: CGFloat = 100
    static let addButtonOffset: CGFloat = 20
}

#Preview {
    FolderScreenView(folderScreenViewModel: .init())
}
