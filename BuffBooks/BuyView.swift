//
//  BuyView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 10/26/23.
//

import SwiftUI


struct BuyView: View {
    var body: some View {
        NavigationView {
            ListView()
                //.navigationBarTitle("Buy")
                .padding()
                .background(Color.color1.edgesIgnoringSafeArea(.all))
                .foregroundColor(Color.color4)
        }
        .navigationTitle("Buy")
                    .toolbarBackground(
                        Color.color2,
                        for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark, for: .navigationBar)


    }
}


struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
