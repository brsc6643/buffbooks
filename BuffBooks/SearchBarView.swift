//
//  SearchBarView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/8/23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String
   
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
           
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
