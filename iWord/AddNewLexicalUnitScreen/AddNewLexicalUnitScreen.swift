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
    @State var originalLexicalUnit: String = ""
    @State var translation: String = ""
    @State var isAlertPresented = false
    @State var isImagePickerPresented = false
    @State var pickedImage: UIImage? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter original word")
            TextField(text: $originalLexicalUnit) { }
            .padding(20)
            .background(Color.gray)
            .cornerRadius(20)
            
            Text("Enter translation")
            TextField(text: $translation) { }
            .padding(20)
            .background(Color.gray)
            .cornerRadius(20)
            
            createButton(title: "AddImage") {
                isImagePickerPresented = true
            }
            
            Spacer()
            
            createButton(title: "Save") {
                isAlertPresented = true
            }

        }
        .padding(.horizontal, 20)
        .alert("You have to fill in all fields", isPresented: $isAlertPresented) {
            Button("Ok", role: .cancel) { }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $pickedImage)
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
                    .padding(.horizontal, 50)
                    .padding(.vertical, 20)
                    .background(Color.green)
                    .cornerRadius(20)
                Spacer()
            }
        }
    }
}

#Preview {
    AddNewLexicalUnitScreen()
}
