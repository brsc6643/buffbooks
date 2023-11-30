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
    
    var body: some View {
        TabView {
            BuyView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
 
            MyListingsView()
                .tabItem {
                    Label("My Listings", systemImage: "list.bullet")
                }
        }
    }
}

