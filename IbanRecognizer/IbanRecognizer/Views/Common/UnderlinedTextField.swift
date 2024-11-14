//
//  UnderlinedTextField.swift
//  IbanRecognizer
//
//  Created by soua hamza on 14/11/2024.
//

import SwiftUI

struct UnderlinedTextField: View {
    @Binding var text: String
    var label: String
    var body: some View {
        TextField(text: $text) {
            Text(label)
        }
        Divider()
            .background(.blue)
    }
}

