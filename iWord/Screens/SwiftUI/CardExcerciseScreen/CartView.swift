// CartView.swift
// iWord
//
// Created by Denis Ulianov on 10/11/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import SwiftUI

struct CartView: View {
    private let initialText: String
    private let secondaryText: String
    private let pngData: Data?
    private let isInHintState: Bool
    
    init(
        initialText: String,
        secondaryText: String,
        pngData: Data?,
        isInHintState: Bool
    ) {
        self.initialText = initialText
        self.secondaryText = secondaryText
        self.pngData = pngData
        self.isInHintState = isInHintState
    }
    
    var body: some View {
        Group {
            if !isInHintState {
                createMainCard()
            } else {
                createHintCard()
            }
        }
    }
    
    private func createMainCard() -> some View {
        ZStack {
            Rectangle()
            VStack {
                if let pngData,
                   let image = UIImage(data: pngData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Text(initialText)
                    .foregroundStyle(.black)
            }
            .padding()
        }
        .foregroundStyle(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 20)
    }
    
    private func createHintCard() -> some View {
        ZStack {
            Rectangle()
            Text(secondaryText)
                .foregroundStyle(.black)
        }
        .foregroundStyle(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 20)
    }
}
