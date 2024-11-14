//
//  ScannerView.swift
//  IbanRecognizer
//
//  Created by soua hamza on 14/11/2024.
//

import SwiftUI

struct ScannerView: View {
    var image: UIImage = UIImage(named: "flower") ?? UIImage()
    @State var cropedImage: UIImage?
    @State var globalViewSize: CGSize = .zero
    
    let mask = CGSize(width: 300, height: 50)
    var body: some View {
            ZStack(alignment: .center) {
                ZStack {
                    Rectangle()
                        .fill(.ultraThickMaterial)
                        .ignoresSafeArea()
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                .blur(radius: 20)
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .mask(
                            Rectangle()
                                .frame(width: mask.width, height: mask.height)
                            
                        )
                        .overlay {
                            Rectangle()
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: mask.width, height: mask.height)
                        }
                    Image(uiImage: cropedImage ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(CGSize.init(width: 0.5, height: 0.5))
                        .overlay {
                            Rectangle()
                                .stroke(Color.black, lineWidth: 1)
                                .frame(width: mask.width, height: mask.height)
                        }
                    
                }
            }
            .navigationTitle(L10n.scannerViewNavigationTitle)
            .onAppear {
                cropedImage = cropImage(inputImage: image)

            }
            
    }
    
    func cropImage(inputImage: UIImage) -> UIImage? {
        let imageViewScale = max(inputImage.size.width / UIScreen.main.bounds.width,
                                 inputImage.size.height / UIScreen.main.bounds.height)

        let cropZone = CGRect(x: (inputImage.size.width - (mask.width * imageViewScale)) / 2 , y: (inputImage.size.height - (mask.height * imageViewScale)) / 2, width: (mask.width * imageViewScale), height: mask.height * imageViewScale)

        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to: cropZone) else {
            return nil
        }
        
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        
        return croppedImage
    }
    
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
