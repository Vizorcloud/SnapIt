//
//  HomeView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/20/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var reportViewModel = reportModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                
                VStack {
                    ZStack {
                        
                        VStack{
                            Spacer()
                            
                            HStack {
                                Text("Hello Maxsem")
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black )
                                    .font(.system(size: 35))
                                    .padding(.horizontal, 24)
                                
                                Spacer()
                            }
                            
                            Divider()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 140)
                    .cornerRadius(25)
                    .ignoresSafeArea()
                    
                    //                    .shadow(color: Color(.lightGray), radius: 10, x: 2, y: 5)
                    
                    HStack {
                        Text("Recent")
                            .multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .opacity(0.9)
                            .font(.system(size: 30))
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 4) {
                            ForEach(reportViewModel.reports) { report in
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
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                    
                    HStack {
                        Text("Useful Links")
                            .multilineTextAlignment(.leading)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .opacity(0.9)
                            .font(.system(size: 30))
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Submit a Report")
                                .padding()
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                            Spacer()
                            Image(systemName: "arrow.right")
                                .padding()
                        }
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 48)
                    }
                    .background(Color(.appYellow))
                    .cornerRadius(10)
                    .padding(.vertical, 10)
                    
                    
                    Link(destination: URL(string: "https://www.cityofsouthgate.org/Government/Departments/Public-Works/Maintenance-Services/Graffiti-Removal-Program")!, label: {
                        HStack {
                            Text("Learn more about our cause")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .font(.system(size: 18))
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width - 50, height: 48)
                        .background(Color.black)
                        .cornerRadius(10)
                    })
                    .padding(.bottom, 24)
                    
                    Spacer()
                }
            }
        }
        .onAppear() {
            reportViewModel.getReports()
        }
    }
}

#Preview {
    HomeView()
}
