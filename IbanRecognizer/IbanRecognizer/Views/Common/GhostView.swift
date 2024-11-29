//
//  GhostView.swift
//  IbanRecognizer
//
//  Created by soua hamza on 14/11/2024.
//

import SwiftUI

struct GhostView: View {
    var imageSystemName: String?
    var title: String
    var body: some View {
        HStack {
            if let imageSystemName = imageSystemName {
                Image(systemName: imageSystemName)
            }
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
