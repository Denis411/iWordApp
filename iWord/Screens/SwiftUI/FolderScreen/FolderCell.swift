// FolderCell.swift
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

struct FolderCell: View {
    private let folderModel: FolderDataModel

    private let editAction:   (FolderDataModel) -> Void
    private let deleteAction: (FolderDataModel) -> Void
    
    init(
        _ folderModel: FolderDataModel,
        editAction:   @escaping (FolderDataModel) -> Void,
        deleteAction: @escaping (FolderDataModel) -> Void
    ) {
        self.folderModel = folderModel

        self.editAction = editAction
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        createContentView()
            .background(Color.white)
            .cornerRadius(20)
            .swipeActions {
                createDeleteButton()
                createEditButton()
            }
            .frame(height: Self.maxHeight)
    }
}

// MARK: - Subviews
private extension FolderCell {
    @ViewBuilder
    func createContentView() -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundStyle(.clear)
            HStack {
                Text(folderModel.name)
                Spacer()
                Text(String(folderModel.numberOfWords))
            }
            .font(.system(size: 40))
            .fontWeight(.bold)
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    func createEditButton() -> some View {
        Button {
            editAction(folderModel)
        } label: {
            ZStack {
                Rectangle()
                Image(systemName: "bubble.and.pencil")
                    .font(.system(size: 50))
            }
            .tint(.yellow)
        }
    }
    
    @ViewBuilder
    func createDeleteButton() -> some View {
        Button {
            deleteAction(folderModel)
        } label: {
            ZStack {
                Rectangle()
                Image(systemName: "trash")
                    .font(.system(size: 50))
            }
            .tint(.red)
        }
    }
}

private extension FolderCell {
    static let maxHeight: CGFloat = 100
    static let maxHorizontalOffset: CGFloat = 200
}

#Preview {
    let model = FolderDataModel(
        id: .init(),
        name: "Name",
        numberOfWords: 10
    )
    FolderCell(
        model,
        editAction:  { _ in },
        deleteAction: { _ in }
    )
}
