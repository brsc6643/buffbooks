//
//  UserData.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 11/8/23.
//

import SwiftUI

class UserData : ObservableObject {
    @Published var userEmail: String?
    
    init(email: String? = nil) {
        self.userEmail = email
    }
    
    func getCurrentUserEmail() -> String? {
        userEmail
    }
}


