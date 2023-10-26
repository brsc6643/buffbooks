//
//  LoginView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 10/26/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var invalidAlert : Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image("Logo")
                .resizable()
                .frame(width: 230, height: 230)
            
            TextField("student email", text: $email)
                .padding()
                .background(Color.white)
                .cornerRadius(8.0)
                .shadow(radius: 3)
            
            SecureField("password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius:3)
            
            Button(action: {
                if !email.hasSuffix("@colorado.edu") && password != "" {
                    invalidAlert = true
                }
                else {BuyView()}
            }) {
                Text("Login with Email")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.color2)
                    .cornerRadius(8.0)
            }
            .alert(isPresented: $invalidAlert) {
                Alert(title: Text("Invalid Login"),
                      message: Text("Buffbooks is only available to CU Boulder students. Please use a valid @colorado.edu email and password."),
                      dismissButton: .default(Text("OK")))
            }
            
            Button(action: {BuyView()}) {
                Text("Login as Guest")
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.color2)
                    .cornerRadius(8.0)
            }
            Spacer()
        }
        .padding()
        .background(Color.color1.edgesIgnoringSafeArea(.all))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
