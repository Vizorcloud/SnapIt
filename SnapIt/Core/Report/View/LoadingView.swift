//
//  loadingView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/22/24.
//

import SwiftUI

struct LoadingView: View {
    @State var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            VStack {
                VStack {
                    Image("snapitlogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 120)
                        .padding(.vertical)
                    Text("SnapIt report sent!")
                        .font(.system(size: 26))
                        .foregroundStyle(.black.opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isActive = false
                }
            }
        } else {
            CameraDataView(isActive: $isActive)
        }
    }
}

#Preview {
    LoadingView()
}
