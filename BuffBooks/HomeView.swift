//
//  HomeView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct HomeView: View {
    
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.color1
        UITabBar.appearance().tintColor = .color1
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    @StateObject var dataGetter = DataGetter()
    @State private var resetKey = UUID()
    var body: some View {
        //NavigationView {
            TabView {
                BuyView(booksGetter: dataGetter)
                    .tabItem {
                        Label("Home", systemImage: "house")
                            .id(resetKey)
                    }
                
                MyListingsView(dataGetter: dataGetter)
                    .tabItem {
                        Label("My Listings", systemImage: "list.bullet")
                            .onTapGesture{ resetKey = UUID() }
                    }
            }
            .navigationBarBackButtonHidden(true)
        //}
        //.navigationBarBackButtonHidden(true)
    }
}

