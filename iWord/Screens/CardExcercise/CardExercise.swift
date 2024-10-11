// CardExercise.swift
// iWord
//
// Created by Denis Ulianov on 10/11/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org

import SwiftUI

struct CardExercise: View {
    let lexicalUnit: LexicalUnit = .init()
    @State var isInHintState: Bool = true
    @State var rotationAngle: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.white
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            rotationAngle = gestureWidthToDegrees(value.translation.width)
                        }
                        .onEnded { _ in
                            rotationAngle = 0
                        }
                )
            
            VStack {
                CartView(
                    initialText: "Cat",
                    secondaryText: "KOT",
                    pngData: lexicalUnit.pngImageData,
                    isInHintState: $isInHintState
                )
            }
            .padding(.vertical, UIScreen.main.bounds.height * 0.15)
            .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
            .allowsHitTesting(false)
            .opacity(countOpacity(rotationAngle))
            .rotationEffect(.degrees(rotationAngle), anchor: .bottom)
            .animation(.easeInOut, value: isInHintState)
        }
    }
}

extension CardExercise {
    static let halfScreenWidth = UIScreen.main.bounds.width / 2
    static let maxAngleInDegrees: CGFloat = 45
    
    func gestureWidthToDegrees(_ width: CGFloat) -> CGFloat {
        let pointsInOneDegree = Self.halfScreenWidth / Self.maxAngleInDegrees
        let currentAngle = width / pointsInOneDegree
        return currentAngle
    }
    
    func countOpacity(_ angleInDegrees: CGFloat) -> CGFloat {
        guard angleInDegrees < Self.maxAngleInDegrees else {
            // should already be fully transparent
            return 0
        }
        let absoluteDegree = abs(angleInDegrees)
        let opacityInOneDegree = 1 / Self.maxAngleInDegrees
        let totalOpacity = opacityInOneDegree * absoluteDegree
        return 1 - totalOpacity
    }
}

struct CartView: View {
    private let initialText: String
    private let secondaryText: String
    private let pngData: Data?
    @Binding var isInHintState: Bool
    
    init(
        initialText: String,
        secondaryText: String,
        pngData: Data?,
        isInHintState: Binding<Bool>
    ) {
        self.initialText = initialText
        self.secondaryText = secondaryText
        self.pngData = pngData
        self._isInHintState = isInHintState
    }
    
    var body: some View {
        Group {
            if !isInHintState {
                createMainCard()
            } else {
                createHintCard()
            }
        }
        .onTapGesture {
            isInHintState.toggle()
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

#Preview {
    CardExercise()
}
