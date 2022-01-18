//
//  RegisterView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/19/21.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isTryingToRegister: Bool = false
    @State var isRequestErrorViewPresented: Bool = false
    @State var passwordDoesntMatchError: Bool = false
    @State var isActive = false
    @State var errorMessage: String = " "
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
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
                            
                            Text(String(localized: "register_already_account"))
                            Button(action:{
                                self.presentationMode.wrappedValue.dismiss()
                            }){
                                Text(String(localized: "register_login")).foregroundColor(Color("inhollandPink"))
                            }
                         
                        }.padding(.top, 150)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            if isTryingToRegister{
                ProgressView(String(localized: "register_loading"))
            } else {
                VStack(spacing: 8){
                    Text(String(localized: "register_lets_start"))
                        .font(Font.headline.weight(.bold))
                        .padding(.top, 10)
                    Text(String(localized: "register_sign_up_now"))
                        .padding(.bottom, 10)
                    if(email.count > 10 && !isValidEmail(testStr: email)) {
                        Text(String(localized: "register_valid_email"))
                            .foregroundColor(Color.red)
                            .font(.system(size: 10))
                    }
                    else{
                        Text(String(localized: "register_valid_email"))
                            .font(.system(size: 10))
                            .foregroundColor(Color.white)
                    }
                    if(password.count < 8 && password.count > 0){
                    Text(String(localized: "register_characters"))
                        .foregroundColor(Color.red)
                        .font(.system(size: 10))

                    }
                    else{
                        Text(String(localized: "register_characters"))
                            .font(.system(size: 10))
                            .foregroundColor(Color.white)

                    }
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
                    HStack{
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color("inhollandPink"))
                            .padding(.horizontal, 10)
                        SecureField(String(localized: "register_confirm_password"), text: $confirmPassword)
                            .padding(10)
                        
                    }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                    if (password.count > 7 && isValidEmail(testStr: email) && confirmPassword.count > 7){
                        NavigationLink(destination: ConfirmRegistrationView(registerEmail:email), isActive: $isActive) {
                            Button(action: {
                                isTryingToRegister = true
                                if(password == confirmPassword){
                                    LoginViewModel.loginVM.register(register: Register(email: email, password: password), endpoint: .register) { result in
                                        switch result {
                                        case .success(_):
                                            isTryingToRegister = false
                                            self.isActive = true
                                        case.failure:
                                            self.isRequestErrorViewPresented = true
                                            self.errorMessage = String(localized: "register_error1")
                                        }
                                        self.isTryingToRegister = false
                                    }}else{
                                        self.isRequestErrorViewPresented = true
                                        self.errorMessage = String(localized: "register_error2")
                                        isTryingToRegister = false
                                    }
                            }) {
                                Text(String(localized: "register_button"))
                            }.frame(maxWidth: .infinity, minHeight:35)
                                .foregroundColor(.white)
                        }
                        .background(Color("inhollandPink"))
                        .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                        .padding(.top, 20)
                    }
                    else{
                        Text(String(localized: "register_button"))
                            .frame(maxWidth: .infinity, minHeight:35)
                            .foregroundColor(.white)
                        
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                    }
                    
                }.padding()
                    .frame(width: 324, height: 360)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
            }
        } .navigationBarHidden(true)
            .alert(isPresented: $isRequestErrorViewPresented) {
                Alert(title: Text(String(localized: "register_signup_fail")), message: Text(errorMessage), dismissButton: .default(Text(String(localized: "login_try_again"))))
                
            }
    }
}


