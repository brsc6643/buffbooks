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
    
    var body: some Scene {
        WindowGroup {
            if userData.isSignedIn {
                HomeView()
                    .environmentObject(userData)
            }
            else {
                LoginView()
                    .environmentObject(userData)
            }
        }
    }
}
 
