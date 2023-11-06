//
//  BuyView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 10/26/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct BuyView: View {
    var body: some View {
        NavigationView {
            Buy()
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

struct Buy : View {
    @ObservedObject var Books = getData()
    
    var body: some View{
        List(Books.data){ i in
            
            HStack {
                
                if i.imurl != "" {
                    WebImage(url: URL(string: i.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
                }
                
                else {
                    Image("Book").resizable().frame(width: 120, height: 170).cornerRadius(10)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(i.title).fontWeight(.bold)
                    
                    Text(i.authors)
                    
                    Text(i.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading)
                }
            }
        }
    }
}


struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
