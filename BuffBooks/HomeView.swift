//
//  HomeView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/30/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userData: UserData
    
    
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
                
                MyListingsView(listings: dataGetter.fetchListingsForCurrentUser(currentUserEmail: userData.userEmail ?? ""), dataGetter: dataGetter)
                    .tabItem {
                        Label("My Listings", systemImage: "list.bullet")
                            .onTapGesture{ resetKey = UUID() }
                    }
                
                FavoritesView(booksGetter: dataGetter)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
            .environmentObject(userData)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                dataGetter.loadBookSaleInfos()
                userData.isSignedIn = true
            }
        //}
        //.navigationBarBackButtonHidden(true)
    }
}

