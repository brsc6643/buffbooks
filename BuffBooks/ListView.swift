//
//  ListView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/6/23.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct ListView : View {
    @ObservedObject var Books = DataGetter()
    
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

