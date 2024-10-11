// AddNewLexicalUnitScreen.swift
// iWord
//
// Created by Denis Ulianov on 10/9/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org

import SwiftUI

struct AddNewLexicalUnitScreen: View {
    @State var isImagePickerPresented = false
    @State var isAlertPresented = false
    @ObservedObject private var viewModel: NewLexicalUnitViewModel
    
    init(viewModel: NewLexicalUnitViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Enter original word")
                TextField(text: $viewModel.originalLexicalUnit) { }
                    .padding(20)
                    .background(Color.gray)
                    .cornerRadius(20)
                
                Text("Enter translation")
                TextField(text: $viewModel.translation) { }
                    .padding(20)
                    .background(Color.gray)
                    .cornerRadius(20)
                
                HStack {
                    createButton(title: "AddImage") {
                        isImagePickerPresented = true
                    }
                    
                    createButton(title: "Save") {
                        viewModel.saveLexicalUnit()
                    }
                }
                
                if let imageData = viewModel.pickedImage,
                   let pickedImage = UIImage(data: imageData) {
                    createImageView(uiImage: pickedImage)
                        .offset(y: 30)
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .padding(.horizontal, 20)
        .alert(
            "You have to fill in all fields",
            isPresented: $isAlertPresented
        ) {
            Button("Ok", role: .cancel) { }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $viewModel.pickedImage)
        }
    }
    
    @ViewBuilder
    private func createButton(title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(Color.green)
                    .cornerRadius(20)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func createImageView(uiImage: UIImage) -> some View {
        let edge: CGFloat = 300
        ZStack {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: edge, height: edge)
                .cornerRadius(20)
            Image(systemName: "minus")
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: edge / 2, y: -edge / 2)
                .onTapGesture {
                    self.viewModel.nullifyPickedImage()
                }
        }
    }
}

#Preview {
    AddNewLexicalUnitScreen(viewModel: .init())
}
