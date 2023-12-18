////
////  ContentView.swift
////  BuffBooks
////
////  Created by ATLAS Laptop 4 Guest on 10/26/23.
////
//
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData

    
    var body: some View {
        if userData.isSignedIn {
            HomeView()
        }
        else {
            LoginView()
        }

    }
}

#Preview {
    ContentView()
}
