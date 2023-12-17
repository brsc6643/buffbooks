//
//  LoginView.swift
//  BuffBooks
//
//  Created by ATLAS Laptop 4 Guest on 10/26/23.
//

import SwiftUI

struct LoginView: View {
    @State public var email: String = ""
    @State private var password: String = ""
    @State private var invalidAlert : Bool = false
    @State var navigated = false
    @State var isSignedIn: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationStack{
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
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                SecureField("password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius:3)
                
                NavigationLink("", destination: HomeView(), isActive: $navigated)
                
                
                Button(action: {
                    if !email.hasSuffix("@colorado.edu") || password == "" {
                        invalidAlert = true
                    }
                    else {
                        navigated.toggle()
                        userData.logIn(email: email)
                    }
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
                
                
                
                Button(action: {
                    self.navigated.toggle()
                    //UserDefaults.standard.set("guest", forKey: "currentUserEmail")})
                    userData.userEmail = "guest"}) {
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
        .navigationTitle("Login") //end nav stack
        .navigationBarBackButtonHidden(true)
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
