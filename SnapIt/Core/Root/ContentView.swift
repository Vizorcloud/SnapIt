//
//  ContentView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                RootView()
            } else {
                WelcomeView()
            }
        }
    }
 }

#Preview {
    ContentView()
}

//NavigationView {
//     ZStack {  // Use ZStack to set the background for the whole screen
//         Color.gray.opacity(0.2)  // Light gray background
//             .edgesIgnoringSafeArea(.all)  // Ensures the background covers the entire screen
//         
//         VStack {
//             Spacer()
//             
//             // "Let's Get Started" Text as NavigationLink
//             NavigationLink(destination: SignupView()) {
//                    Text("Let's Get Started")
//                         .font(.title2)
//                         .fontWeight(.bold)
//                         .foregroundColor(.white)
//                         .padding()
//                         .background(Color.blue)  // Button background color
//                         .cornerRadius(10)
//             }
//             
//             NavigationLink(destination: LoginView()) {
//                    Text("Already Have an Account? Login")
//                         .font(.title3)
//                         .fontWeight(.bold)
//                         .foregroundColor(.blue)
//             }
//             .padding()
//             
//             Spacer()
//         }
//     }
// }
