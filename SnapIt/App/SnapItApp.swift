//
//  SnapItApp.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/6/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import FirebaseAppCheck

@main
struct SnapItApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var locationManager = LocationManager()
    
    init() {
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()  // Initialize Firebase
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(locationManager)

        }
    }
}
