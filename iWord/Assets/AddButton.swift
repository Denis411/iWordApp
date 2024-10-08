// AddButton.swift
// iWord
//
// Created by Denis Ulianov on 10/7/24.
// LinkedIn: https://www.linkedin.com/in/denis-u-926707256/
// Copyright © 2024 . All rights reserved.
//
// This project is part of the dissertation research for the 09.04.03 curriculum at Tambov State University.
// University website: https://tambovstateuniversity.org 

import SwiftUI

struct AddButton: View {
    private let action: () -> Void
    
    init(action: @autoclosure @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .background(.clear)
                    .foregroundStyle(Color.white)
                Image(systemName: "plus")
                    .font(.system(size: Self.addButtonImageFontSize))
            }
            .shadow(radius: Self.addButtonShadowRadius)
        }
    }
}

extension AddButton: Equatable {
    static func == (lhs: AddButton, rhs: AddButton) -> Bool {
        true
    }
}

fileprivate extension AddButton {
    static let addButtonShadowRadius: CGFloat = 30
    static let addButtonImageFontSize: CGFloat = 60
}
