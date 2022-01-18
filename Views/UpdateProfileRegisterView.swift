//
//  UpdateProfileRegisterView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import SwiftUI

struct UpdateProfileRegisterView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var department: String = ""
    @State var jobTitle: String = ""
    @State var location: String = ""
    @State var isTryingToSubmit: Bool = false
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
                            
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                if isTryingToSubmit {
                    ProgressView()
                } else {
                    VStack(spacing: 8){
                        Text(String(localized: "profile_last_steps"))
                            .fontWeight(.bold)
                        Text(String(localized: "profile_vitality"))
                            .padding(.bottom, 50)
                        HStack{
                            Spacer(minLength: 20)
                            Image("ic_person").foregroundColor(Color("inhollandPink"))
                                .frame(width: 30, height: 30, alignment: .center)
                            TextField(String(localized: "profile_first_name"), text: $firstName)
                                .autocapitalization(.none)
                                .padding(10)
                            
                        }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                        HStack{
                            Spacer(minLength: 20)
                            Image("ic_person").foregroundColor(Color("inhollandPink"))
                                .frame(width: 30, height: 30, alignment: .center)
                            TextField(String(localized: "profile_last_name"), text: $lastName)
                                .autocapitalization(.none)
                                .padding(10)
                            
                        }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                        HStack{
                            Spacer(minLength: 20)
                            Image("ic_suitcase").foregroundColor(Color("inhollandPink"))
                                .frame(width: 30, height: 30, alignment: .center)
                            TextField(String(localized: "profile_job_title"), text: $jobTitle)
                                .autocapitalization(.none)
                                .padding(10)
                            
                        }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                        HStack{
                            Spacer(minLength: 20)
                            Image("ic_location").foregroundColor(Color("inhollandPink"))
                                .frame(width: 30, height: 30, alignment: .center)
                            TextField(String(localized: "profile_location"), text: $location)
                                .autocapitalization(.none)
                                .padding(10)
                                .foregroundColor(Color.black)
                            
                        }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                        if(firstName.count > 1 && lastName.count > 1 && jobTitle.count > 1 && location.count > 1){
                        Button(action: {
                            isTryingToSubmit = true
                            LoginViewModel.loginVM.updateProfile(profile: Profile(firstName: firstName, lastName: lastName, jobTitle: jobTitle, location: location), endpoint: .register)   { result in
                                switch result {
                                case .failure:
                                    self.isRequestErrorViewPresented = true
                                    self.isTryingToSubmit = false
                                case .success:
                                    self.isTryingToSubmit = false
                                }
                            }
                        }) {
                            Text(String(localized: "profile_continue"))
                        }.frame(maxWidth: .infinity, minHeight:35)
                            .foregroundColor(.white)
                        
                            .background(Color("inhollandPink"))
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        }
                        else{
                            Text(String(localized: "profile_continue"))
                                .frame(maxWidth: .infinity, minHeight:35)
                            .foregroundColor(.white)
                        
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        }
                    }.padding()
                        .frame(width: 324, height: 450)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                   
                }
            }.alert(isPresented: $isRequestErrorViewPresented) {
                Alert(title: Text(String(localized: "error_message")), message: Text(String(localized: "profile_error")), dismissButton: .default(Text(String(localized: "login_try_again"))))
            }
        }
    }
}
