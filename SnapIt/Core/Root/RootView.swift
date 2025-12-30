//
//  RootView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/20/24.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var locationManager: LocationManager //placeholder
    
    @State var selectedTab = 1
    @State var isReporting: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
//            Text("Location: \n\(locationManager.location?.coordinate.latitude ?? 0.0), \(locationManager.location?.coordinate.longitude ?? 0.0)")
            HomeView()
                .tabItem {
                    Label("Home", systemImage: selectedTab == 1 ? "house.fill" : "house")
                        .environment(\.symbolVariants, .none) // here
                }
                .tag(1)
            
            LoadingView()
                .tabItem {
                    Label("Create Report", systemImage: selectedTab == 2 ? "plus.app.fill" : "plus.app")
                        .environment(\.symbolVariants, .none) // here
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == 3 ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none) // here
                }
                .tag(3)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(LocationManager())
}
