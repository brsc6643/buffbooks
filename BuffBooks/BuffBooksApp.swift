//
//  BuffBooksApp.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 10/26/23.
//

import SwiftUI

@main
struct BuffBooksApp: App {
    @StateObject var userData = UserData()
    @State private var isUserLoggedIn = false
    
    init() {
        isUserLoggedIn = userData.isSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                HomeView(isUserLoggedIn: $isUserLoggedIn)
                    .environmentObject(userData)
            }
            else {
                LoginView(isUserLoggedIn: $isUserLoggedIn)
                    .environmentObject(userData)
            }
        }
    }
}
 
