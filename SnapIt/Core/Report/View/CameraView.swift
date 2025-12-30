//
//  CameraView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/20/24.
//

import SwiftUI

struct CameraView: View {
    
    @Environment(\.verticalSizeClass) var vertiSizeClass
    
    @State internal var VM = CameraViewModel()
    
    @Binding var imageData: Data?
    @Binding var showCamera: Bool
    
    let controlButtonWidth: CGFloat = 120
    let controlFrameHeight: CGFloat = 90
    
    var isLandscape: Bool { vertiSizeClass == .compact }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    cameraPreview
                    if isLandscape {
                        verticalControlBar
                            .frame(width: controlFrameHeight)
                    }
                }
                if !isLandscape {
                    horizontalControlBar
                        .frame(height: controlFrameHeight)
                }
            }
        }
    }
    
    private var cameraPreview: some View {
        GeometryReader { geo in
            CameraPreview(cameraVM: $VM, frame: geo.frame(in: .global))
                .onAppear() {
                    VM.requestAccessAndSetup()
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CameraView(imageData: .constant(nil), showCamera: .constant(true))
}
