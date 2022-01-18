//
//  ConfirmRegistrationView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/11/22.
//

import SwiftUI

struct ConfirmRegistrationView: View {
    let registerEmail: String
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
                            
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                
                
                
                VStack(spacing: 8){
                    HStack{
                        
                        VStack {
                            
                            Text(String(localized: "confirm_register_title"))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(20)
                            HStack{
                                Text(String(localized: "confirm_register_description")) + Text(registerEmail).fontWeight(.bold)
                            }.multilineTextAlignment(.center)
                                .padding(10)
                            
                            Text(String(localized: "confirm_register_subtitle"))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 10)
                            
                            NavigationLink(destination: LoginView()) {
                                Text(String(localized: "confirm_register_button"))
                                    .frame(maxWidth: .infinity, minHeight:35)
                                    .foregroundColor(.white)
                                
                                    .background(Color("inhollandPink"))
                                    .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                    .padding(.top, 20)
                            }
                            
                        }.padding()
                            .frame(width: 350, height: 400)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                    }
                }
                
            }
        }.navigationBarHidden(true)
    }
    
}
