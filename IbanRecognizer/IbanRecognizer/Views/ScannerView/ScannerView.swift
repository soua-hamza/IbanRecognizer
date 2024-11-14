//
//  ScannerView.swift
//  IbanRecognizer
//
//  Created by soua hamza on 14/11/2024.
//

import SwiftUI

struct ScannerView: View {
    var image: Image?
    var body: some View {
        VStack {
            image?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .navigationTitle(L10n.scannerViewNavigationTitle)
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
