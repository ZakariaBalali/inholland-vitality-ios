//
//  LoginView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/15/21.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isTryingToLogin: Bool = false
    @State var isRequestErrorViewPresented: Bool = false
    var body: some View {
        NavigationView{
            ZStack{
                ZStack {
                    
                    VStack(spacing: 0) {
                        ZStack{
                            Color("inhollandPink")
                            Image("vitalityIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .offset(y: -50)
                        }
                        ZStack{
                            Color.white
                            
                            HStack{
                                Text(String(localized: "login_no_account"))
                                
                                VStack{
                                    NavigationLink(destination: RegisterView(), label: { Text(String(localized: "login_sign_up")) }).foregroundColor(Color("inhollandPink"))
                                }
                                
                            }.padding(.top, 150)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                if isTryingToLogin {
                    ProgressView()
                } else {
                    VStack(spacing: 8){
                        Text(getGreeting() + ",")
                            .font(Font.headline.weight(.bold))
                        Text(String(localized: "login_continue"))
                            .padding(.bottom, 50)
                        HStack{
                            Image(systemName: "envelope.fill").foregroundColor(Color("inhollandPink"))
                                .padding(.horizontal, 10)
                            TextField(String(localized: "hint_email"), text: $email)
                                .autocapitalization(.none)
                                .padding(10)
                        }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                        
                        HStack{
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("inhollandPink"))
                                .padding(.horizontal, 10)
                            SecureField(String(localized: "login_password"), text: $password)
                                .padding(10)
                            
                        }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                        if(password.count > 1 && isValidEmail(testStr: email)){
                            Button(action: {
                                isTryingToLogin = true
                                LoginViewModel.loginVM.login(for: Login(email: email, password: password)) { result in
                                    switch result {
                                    case .success(_):
                                        print("success")
                                    case.failure(let error):
                                        self.isRequestErrorViewPresented = true
                                        switch error {
                                        case .urlError(let urlError):
                                            print("URL Error: \(String(describing: urlError))")
                                        case .decodingError(let decodingError):
                                            print("Decoding Error: \(String(describing: decodingError))")
                                        case .genericError(let error):
                                            print("Error: \(String(describing: error))")
                                        }
                                    }
                                    self.isTryingToLogin = false
                                }
                            }) {
                                Text(String(localized: "login_login"))
                            }.frame(maxWidth: .infinity, minHeight:35)
                                .foregroundColor(.white)
                            
                                .background(Color("inhollandPink"))
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                .padding(.top, 20)
                        }
                        
                        else{
                            Text(String(localized: "login_login"))
                                .frame(maxWidth: .infinity, minHeight:35)
                                .foregroundColor(.white)
                            
                                .background(Color.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                .padding(.top, 20)
                        }
                        
                    }.padding()
                        .frame(width: 324, height: 283)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                }
            }.alert(isPresented: $isRequestErrorViewPresented) {
                Alert(title: Text(String(localized: "error_message")), message: Text(String(localized: "login_error")), dismissButton: .default(Text(String(localized: "login_try_again"))))
            }
        } .navigationBarHidden(true)
    }
}
