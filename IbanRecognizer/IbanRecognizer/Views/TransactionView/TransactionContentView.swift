//
//  TransactionContentView.swift
//  IbanRecognizer
//
//  Created by soua hamza on 13/11/2024.
//

import SwiftUI

struct TransactionContentView: View {
    @Binding var iban: String

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(L10n.transactionViewText)
                    Spacer()
                }.padding(.top, 20)
                HStack {
                                        
                    NavigationLink {
                        ScannerView()
                    } label: {
                        GhostView(ImageSystemName: "camera", title: L10n.transactionViewScannerButton)
                    }
                    
                    Spacer()
                    
                    GhostView(ImageSystemName: "square.and.arrow.up", title: L10n.transactionViewImportButton)
                }.padding(.top, 20)
                    .padding(.bottom, 20)
                
                UnderlinedTextField(text: $iban, label: L10n.transactionViewIbanPlaceholder)
                
                Spacer()
            }.padding(.leading, 10)
                .padding(.trailing, 10)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle(L10n.transactionViewNavigationTitle)
        }
    }
}
