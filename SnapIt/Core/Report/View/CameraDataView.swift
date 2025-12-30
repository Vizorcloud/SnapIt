//
//  CameraView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/20/24.
//

import SwiftUI

struct CameraDataView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var imageData: Data? = nil
    @State private var showCamera: Bool = false
    @State private var report = Report()
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Submit a Report")
                    .multilineTextAlignment(.leading)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black )
                    .font(.system(size: 35))
                    .padding(.horizontal, 5)
                    .padding(.top, 10)
                
                Spacer()
            }
            
            Divider()
            
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.gray)
            }
            
            Button {
                showCamera = true
            } label: {
                HStack {
                    Text("Take a Photo")
                        .fontWeight(.semibold)
                        .font(.system(size:20))
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 50, height: 48)
            }
            .background(Color(.black))
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                Task {
                    report.latitude = locationManager.location?.coordinate.latitude ?? 0.0
                    report.longitude = locationManager.location?.coordinate.longitude ?? 0.0
                    let success = await viewModel.saveImage(report: report, image: UIImage(data: imageData!)!)
                    if success {
                        print("Success!")
                        imageData = nil
                        isActive = true
                        print($isActive)
                    }
                }
            } label: {
                HStack {
                    Text("Send")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.black)
                .opacity(0.9)
                .font(.system(size: 20))
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.appYellow))
            .disabled((imageData == nil))
            .opacity((imageData != nil) ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
        }
        .padding()
        .fullScreenCamera(isPresented: $showCamera, imageData: $imageData)
        
    }
}

#Preview {
    CameraDataView(isActive: .constant(false))
}
