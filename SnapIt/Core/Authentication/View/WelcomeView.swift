//
//  WelcomeView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/21/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Image("snapitlogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .padding(.vertical, 18)
                
                Text("Keeping Cities Clean \n One Snap at a Time")
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .opacity(0.9)
                    .font(.system(size: 26))
                
                Spacer()
                
                Spacer()
                
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Let's Get Started")
                        .fontWeight(.semibold)
                        .font(.system(size: 23))
                        .foregroundColor(.black)
                        .opacity(0.9)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 48)
                }
                .frame(height: 60)
                .background(.appYellow)
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30.0).stroke(.black, lineWidth: 4)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                        .opacity(0.8)
                )
                .padding(10)
                
                NavigationLink {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 5) {
                        Text("Already have an account?")
                            .foregroundStyle(.black)
                            .opacity(0.9)
                        Text("Log In")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .opacity(0.9)
                    }
                    .font(.system(size: 20))
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
