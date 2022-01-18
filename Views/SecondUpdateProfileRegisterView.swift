//
//  SecondUpdateProfileRegisterView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/5/22.
//

import SwiftUI

struct SecondUpdateProfileRegisterView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var department: String = ""
    @State var jobTitle: String = ""
    @State var location: String = ""
    @State var isTryingToSubmit: Bool = false
    @State var description: String = String(localized: "profile2_description")
    @State var isRequestErrorViewPresented: Bool = false
    @State private var profileIsShowPhotoLibrary = false
    @State private var profileImage = UIImage()
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
                        HStack{
                            
                            VStack {
                                Button(action: {
                                    self.profileIsShowPhotoLibrary = true
                                }) {
                                    if(profileImage.size.width != 0){
                                        Image(uiImage: self.profileImage)
                                            .resizable()
                                            .frame(width: CGFloat(80), height: CGFloat(80), alignment: .leading)
                                            .clipShape(Circle())
                                    }else{
                                        ZStack{
                                            Color("textfieldGray")
                                            Image(systemName: "camera.fill")
                                                .foregroundColor(Color("inhollandPink"))
                                        } .frame(width: CGFloat(80), height: CGFloat(80), alignment: .leading)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            Text(String(localized: "profile2_photo"))
                        }                                .frame(maxWidth: .infinity, alignment: .leading)
                        
                            .fullScreenCover(isPresented: $profileIsShowPhotoLibrary) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
                            }
                        
                        TextEditor( text: $description
                        )
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .background(Color("textfieldGray"))

                            .accentColor(.black)
                            .foregroundColor(description == String(localized: "profile2_description") ? .gray  : .black)

                            .onTapGesture {
                                description = ""
                            }
                        
                        if(description == String(localized: "profile2_description") || (description.count < 11 || description.count > 130) ){
                            Text(String(localized: "profile2_start"))
                            .frame(maxWidth: .infinity, minHeight:35)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                       
                        }
                        else{
                            Button(action: {
                                isTryingToSubmit = true
                                LoginViewModel.loginVM.updateProfileComplete(uiImage: profileImage, profile: ProfileComplete(firstName: firstName, lastName: lastName, jobTitle: jobTitle, location: location, description: description), endpoint: .register)   { result in
                                    switch result {
                                    case .failure:
                                        self.isRequestErrorViewPresented = true
                                        self.isTryingToSubmit = false
                                    case .success:
                                        self.isTryingToSubmit = false
                                        
                                    }
                                    
                                }
                            }) {
                                Text(String(localized: "profile2_start"))
                            }.frame(maxWidth: .infinity, minHeight:35)
                                .foregroundColor(.white)
                                .background(Color("inhollandPink"))
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                .padding(.top, 20)
                        }
                        
                    }.padding()
                        .frame(width: 350, height: 350)
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
