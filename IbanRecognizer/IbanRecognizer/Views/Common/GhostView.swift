//
//  GhostView.swift
//  IbanRecognizer
//
//  Created by soua hamza on 14/11/2024.
//

import SwiftUI

struct GhostView: View {
    var ImageSystemName: String
    var title: String
    var body: some View {
        HStack {
            Image(systemName: ImageSystemName)
            Text(title)
        }.padding(10)
        .foregroundColor(.blue)
        .background(.white)
        .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.blue, lineWidth: 1)
                )
    }
}
