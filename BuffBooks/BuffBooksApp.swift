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
            ContentView()
                .environmentObject(userData)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    userData.isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
                }
        }
    }
}
 
