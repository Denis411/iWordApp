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

final class CardExerciseViewModel: ObservableObject {
    private let listOfModels: [LexicalUnit]
    @Published var currentModelIndex: Int
    
    init(listOfModels: [LexicalUnit]) {
        if listOfModels.count == 0 {
            assertionFailure()
        }
        
        self.listOfModels = listOfModels
        self.currentModelIndex = 0
    }
    
    // User knows the word
    func reactPositively () {
        
    }
    
    // user does not know the word
    func reactNegatively() {
        
    }
    
    func closeExercise() {
        
    }
}

struct CardExercise: View {
    @ObservedObject private var cardExerciseViewModel: CardExerciseViewModel
    let lexicalUnit: LexicalUnit = .init()
    @State var isInHintState: Bool = false
    @State var rotationAngle: CGFloat = 0
    
    init(cardExerciseViewModel: CardExerciseViewModel) {
        self.cardExerciseViewModel = cardExerciseViewModel
    }
    
    var body: some View {
        ZStack {
            createCloseButton {
                cardExerciseViewModel.closeExercise()
            }
                .zIndex(1000)
            countBackground(rotationAngle)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    isInHintState.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            rotationAngle = gestureWidthToDegrees(value.translation.width)
                        }
                        .onEnded { _ in
                            if rotationAngle > Self.maxAngleInDegrees {
                                cardExerciseViewModel.reactPositively()
                            } else if rotationAngle < -Self.maxAngleInDegrees {
                                cardExerciseViewModel.reactNegatively()
                            }
                            rotationAngle = 0
                        }
                )
            
            VStack {
                CartView(
                    initialText: "Cat",
                    secondaryText: "KOT",
                    pngData: lexicalUnit.pngImageData,
                    isInHintState: isInHintState
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
    
    @ViewBuilder
    private func createCloseButton(action: @escaping () -> Void) -> some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    action()
                } label: {
                    ZStack {
                        Color.white
                            .frame(width: 30, height: 30)
                            .cornerRadius(15)
                            .shadow(radius: 15)
                        Image(systemName: "plus")
                            .rotationEffect(.degrees(45), anchor: .center)
                    }
                }
            }
            Spacer()
        }
        .padding(.top, 20)
        .padding(.trailing, 20)
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
    
    func countBackground(_ angleInDegrees: CGFloat) -> Color {
        if angleInDegrees > 0 {
            return Color(red: 0, green: 1, blue: 0)
        } else if angleInDegrees < 0 {
            return Color(red: 1, green: 0, blue: 0)
        } else {
            return .white
        }
    }
}

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

#Preview {
    
    CardExercise(cardExerciseViewModel: .init(listOfModels: [.init(), .init()]))
}
