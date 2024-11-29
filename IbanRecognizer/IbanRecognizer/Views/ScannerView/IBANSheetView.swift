//
//  IBANSheetView.swift
//  IbanRecognizer
//
//  Created by HAMZA on 17/11/2024.
//

import SwiftUI

struct IBANSheetView: View {
    var iban: String
    var validate: () -> Void
    var retry: () -> Void
    var body: some View {
        VStack {
            Text(L10n.ibanSheetViewTitle)
                .bold()
                .padding(.bottom, 10)
            Text(L10n.ibanSheetViewValidate)
            Text(iban)
                .bold()
            Button(L10n.ibanSheetViewValidate) {
                validate()
            }
            Button {
                retry()
            } label: {
                GhostView(imageSystemName: nil, title: L10n.ibanSheetViewRetry)
            }
        }.presentationDetents([.medium])
    }
}
