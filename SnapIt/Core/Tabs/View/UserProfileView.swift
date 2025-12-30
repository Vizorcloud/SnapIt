//
//  ReportsView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/20/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


struct UserProfileView: View {
//    struct FakePhoto: Identifiable {
//        let id = UUID().uuidString
//        var imageURLString = "https://firebasestorage.googleapis.com:443/v0/b/snapit-15754.appspot.com/o/2QqoqMyPieZTIxNKF5O9FZiE23l2%2FF0161095-F104-47D2-A7B7-A8EB9ADECD49.jpeg?alt=media&token=1b7c5dd1-d4a0-45ad-a1e5-0b7f900192a5"
//    }
    
//    let reports = [FakePhoto(),FakePhoto(),FakePhoto(),FakePhoto(),FakePhoto(),FakePhoto()]
    var reports: [UserReport]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 4) {
                ForEach(reports) { report in
                    let imageURL = URL(string: report.imageURLString) ?? URL(string: "")
                    
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 4)
    }
}
