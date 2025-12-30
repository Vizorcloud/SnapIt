//
//  View+.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/20/24.
//

import Foundation
import SwiftUI

extension View {
    func fullScreenCamera(isPresented: Binding<Bool>, imageData: Binding<Data?>) -> some View {
        self
            .fullScreenCover(isPresented: isPresented, content: {
                CameraView(imageData: imageData, showCamera: isPresented)
            })
    }
}
