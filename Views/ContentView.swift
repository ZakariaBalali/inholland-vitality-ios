//
//  ContentView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/15/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel.loginVM
    let userDefaults = UserDefaults.standard
    
    init() {
            UITextView.appearance().backgroundColor = .clear
        }
    var body: some View {
        if(userDefaults.bool(forKey: "firstLaunch") == true){
            if !loginViewModel.isAuthenticated && !loginViewModel.needsToFillInProfile {
                LoginView()
            } else if loginViewModel.isAuthenticated && !loginViewModel.needsToFillInProfile && !loginViewModel.needsToFillInProfile2 && userDefaults.bool(forKey: "needsToFillInProfile") == false{
                HomeView()
            }
            else if ((loginViewModel.isAuthenticated && userDefaults.bool(forKey: "needsToFillInProfile") == true) || (loginViewModel.isAuthenticated && loginViewModel.isAuthenticated && loginViewModel.needsToFillInProfile)) {
                UpdateProfileRegisterView().overlay(alignment: .top, content: {
                    Color("inhollandPink")
                        .background(.regularMaterial)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 0)
                })
            }
            else if loginViewModel.isAuthenticated && loginViewModel.needsToFillInProfile2{
                SecondUpdateProfileRegisterView().overlay(alignment: .top, content: {
                    Color("inhollandPink")
                        .background(.regularMaterial)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 0)
                })
            }
            else if(!loginViewModel.isAuthenticated && loginViewModel.needsToFillInProfile){
                ConfirmRegistrationView(registerEmail: loginViewModel.registerEmail)
            }
            
        }
        else{
            TutorialView()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

