//
//  UpdateProfileView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/29/21.
//

import SwiftUI

struct UpdateProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var jobTitle: String = ""
    @State var location: String = ""
    @State var description: String = ""
    @State var isTryingToSubmit: Bool = false
    @State var isRequestErrorViewPresented: Bool = false
    @State private var profileIsShowPhotoLibrary = false
    @State private var profileImage = UIImage()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        VStack{
            if isTryingToSubmit {
                ProgressView()
            } else {
                VStack(spacing: 8){
                    Text(String(localized: "edit_profile_photo"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.headline.weight(.bold))
                    VStack {
                        if(profileImage.size.width != 0){
                            Image(uiImage: self.profileImage)
                                .resizable()
                                .frame(width: CGFloat(100), height: CGFloat(100), alignment: .leading)
                                .clipShape(Circle())
                        }else{
                            AsyncImage(url: URL(string: userViewModel.user?.profilePicture ?? "empty")) { image in
                                image.resizable()
                            } placeholder: {
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 100))
                            }
                            .frame(width: CGFloat(100), height: CGFloat(100), alignment: .leading)
                            .clipShape(Circle())
                        }
                        Button(action: {
                            self.profileIsShowPhotoLibrary = true
                        }) {
                            VStack {
                                Text(String(localized: "edit_profile_edit"))
                                    .foregroundColor(Color("inhollandPink"))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            
                        }
                    }
                    .fullScreenCover(isPresented: $profileIsShowPhotoLibrary) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$profileImage)
                    }
                    
                    Text(String(localized: "edit_profile_personal_info"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.headline.weight(.bold))
                    HStack{
                        Spacer(minLength: 20)
                        Image("ic_person").foregroundColor(Color("inhollandPink"))
                            .frame(width: 30, height: 30, alignment: .center)
                        TextField(String(localized: "profile_first_name"), text: $firstName)
                            .autocapitalization(.none)
                            .padding(10)
                            .accentColor(.black)
                        
                    }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                    HStack{
                        Spacer(minLength: 20)
                        Image("ic_person").foregroundColor(Color("inhollandPink"))
                            .frame(width: 30, height: 30, alignment: .center)
                        TextField(String(localized: "profile_last_name"), text: $lastName)
                            .autocapitalization(.none)
                            .padding(10)
                            .accentColor(.black)
                        
                    }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                    HStack{
                        Spacer(minLength: 20)
                        Image("ic_suitcase").foregroundColor(Color("inhollandPink"))
                            .frame(width: 30, height: 30, alignment: .center)
                        TextField(String(localized: "profile_job_title"), text: $jobTitle)
                            .autocapitalization(.none)
                            .padding(10)
                            .accentColor(.black)
                        
                    }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                    HStack{
                        Spacer(minLength: 20)
                        Image("ic_location").foregroundColor(Color("inhollandPink"))
                            .frame(width: 30, height: 30, alignment: .center)
                        TextField(String(localized: "profile_location"), text: $location)
                            .autocapitalization(.none)
                            .padding(10)
                            .foregroundColor(Color.black)
                            .accentColor(.black)
                        
                    }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                    
                    if(description.count > 130){
                        Text(String(localized: "profile_description") + String(description.count) + String(localized: "profile_characters"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(Font.headline.weight(.bold))
                        .foregroundColor(Color.red)
                    }
                        
                    else{
                        Text(String(localized: "profile_description") + String(description.count) + String(localized: "profile_characters"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.headline.weight(.bold))
                    }
                    HStack{
                        TextView(
                            text: $description
                        )
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: .infinity)
                            .accentColor(.black)
                        
                    }.background(Color("textfieldGray").clipShape(RoundedRectangle(cornerRadius:20)))
                    
                    if(self.firstName.count > 3 && self.lastName.count > 3 && self.jobTitle.count > 3 && self.location.count > 3  && self.description.count < 131){
                        Button(action: {
                            isTryingToSubmit = true
                            LoginViewModel.loginVM.updateProfileComplete(uiImage: profileImage, profile: ProfileComplete(firstName: firstName, lastName: lastName, jobTitle: jobTitle, location: location, description: description), endpoint: .register)   { result in
                                switch result {
                                case .failure:
                                    self.isRequestErrorViewPresented = true
                                    self.isTryingToSubmit = false
                                case .success:
                                    self.isTryingToSubmit = false
                                    self.presentationMode.wrappedValue.dismiss()
                                    self.userViewModel.user = UserResponse(id: userViewModel.user?.id ?? " ", firstName: firstName, lastName: lastName, jobTitle: jobTitle, location: location, description: description, challenges: userViewModel.user?.challenges, followers: userViewModel.user?.followers, profilePicture: userViewModel.user?.profilePicture, points: userViewModel.user?.points, following: userViewModel.user?.following)
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
                    .background(Color.white)
                    .offset(y: -50)
            }
        }.alert(isPresented: $isRequestErrorViewPresented) {
            Alert(title: Text(String(localized: "error_message")), message: Text(String(localized: "profile_error")), dismissButton: .default(Text(String(localized: "login_try_again"))))
            
        }.offset(y: 40)
            .onAppear{self.firstName = userViewModel.user?.firstName ?? " "
                self.lastName = userViewModel.user?.lastName ?? " "
                self.jobTitle = userViewModel.user?.jobTitle ?? " "
                self.location = userViewModel.user?.location ?? " "
                self.description = userViewModel.user?.description ?? " "
            }
        
    }
}
