//
//  ScannerView.swift
//  IbanRecognizer
//
//  Created by soua hamza on 14/11/2024.
//

import SwiftUI

struct ScannerView: View {
    @ObservedObject var scannerViewModel: ScannerViewModel
    @State var currentFrame: UIImage = UIImage()
    
    let mask = CGSize(width: UIScreen.main.bounds.width - 50, height: 60)
    var body: some View {
            ZStack(alignment: .center) {
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                    
                    Image(uiImage: currentFrame)
                        .resizable()
                        .scaledToFill()
                }.brightness(0.3)

                Image(uiImage: currentFrame)
                        .resizable()
                        .scaledToFill()
                        .mask(
                            Rectangle()
                                .frame(width: mask.width, height: mask.height)
                            
                        )
                        .overlay {
                            Rectangle()
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: mask.width, height: mask.height)
                        }
            }
            .onChange(of: scannerViewModel.currentFrame, { oldValue, newValue in
                if let newValue = newValue {
                    currentFrame = UIImage(cgImage: newValue)
                    scannerViewModel.cropedFrame = cropImage(inputImage: currentFrame)
                }
            })
            .onAppear {
                scannerViewModel.handleCameraPreviews()
            }
            .navigationTitle(L10n.scannerViewNavigationTitle)
    }
    
    func cropImage(inputImage: UIImage) -> CGImage? {
        let imageViewScale = max(inputImage.size.width / UIScreen.main.bounds.width,
                                 inputImage.size.height / UIScreen.main.bounds.height)

        let cropZone = CGRect(x: (inputImage.size.width - (mask.width * imageViewScale)) / 2 , y: (inputImage.size.height - (mask.height * imageViewScale)) / 2, width: (mask.width * imageViewScale), height: mask.height * imageViewScale)

        guard let croppedImage: CGImage = inputImage.cgImage?.cropping(to: cropZone) else {
            return nil
        }
        
        return croppedImage
    }
    
}

