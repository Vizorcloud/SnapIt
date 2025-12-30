//
//  ProfileView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/14/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
final class reportModel: ObservableObject {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Published private(set) var reports: [UserReport] = []
    
    func getReports() {
        Task {
            let userReports = try await AuthViewModel.shared.fetchAllUserReports(userID: Auth.auth().currentUser?.uid ?? "")
            
            reports = userReports
            print(reports)
            // print(userReports.last?.imageURLString ?? "")
        }
    }
}



struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var reportViewModel = reportModel()
    
    var body: some View {
        if let user = viewModel.currentUser {
            VStack {
                
                List {
                    Text("Your Profile")
                        .multilineTextAlignment(.leading)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black )
                        .font(.system(size: 30))
                        .padding(.horizontal, 5)
                        .padding(.vertical, 10)
                    
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    Section("General") {
                        HStack {
                            SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                            
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Section("Account") {
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                        }
                        
                        Button {
                            print("Sign out...")
                        } label: {
                            SettingRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                        }
                    }
                    
                    Text("Your Reports")
                        .multilineTextAlignment(.leading)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black )
                        .font(.system(size: 25))
                        .padding(.horizontal, 5)
                        .padding(.top, 10)
                    
                    ForEach(reportViewModel.reports) { report in
                        let imageURL = URL(string: report.imageURLString) ?? URL(string: "")
                        
                        HStack {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipped()
                                
                                
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack {
                                HStack {
                                    Text("Status: \(report.status)")
                                        .multilineTextAlignment(.leading)
                                        .opacity(0.5)
                                        .font(.system(size: 14))
                                    
                                    Image(systemName: "clock")
                                        .multilineTextAlignment(.leading)
                                        .opacity(0.5)
                                        .font(.system(size: 14))
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 6)
                                
                                Text("Date Created: \(report.dateCreated)")
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.5)
                                    .font(.system(size: 14))
                            }
                        }
                        
                    }
                }
            }
            .onAppear() {
                reportViewModel.getReports()
            }
        }
    }
}

#Preview {
    ProfileView()
}
