//
//  OverviewPlaceholder.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/14/22.
//

import SwiftUI

import SwiftUI

struct OverViewPlaceholder: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                ZStack{
                    VStack(spacing: 0){
                        TopBarOverView(userViewModel: UserViewModel.userVM, user: UserViewModel.userVM.user ?? UserResponse(id: "", firstName: String(localized: "loading_placeholder"), lastName: "", jobTitle: "", location: " ", description: " ", challenges: [Challenge(id: " ", progress: 0)], followers: [Followers(id: " ")], profilePicture: " ", points: 0, following: false))
                        VStack{
                            VStack{
                                
                                HStack{
                                    Image("shoe_icon_pink")
                                    Text(NSLocalizedString("active_activities", comment: ""))
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 5)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ChallengeCellPlaceholder()
                                        ChallengeCellPlaceholder()
                                        
                                    }
                                }
                                
                            }                        }.padding()
                            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.5)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                            .offset(y:-20)
                        
                    }
                }
                ZStack{
                    
                    Color.white
                    VStack{
                        VStack{
                            
                            HStack{
                                Image(systemName: "lightbulb")
                                    .foregroundColor(Color("inhollandPink"))

                                Text(NSLocalizedString("discover_activities", comment: ""))

                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 5)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ChallengeCellPlaceholder()
                                    ChallengeCellPlaceholder()
                                }
                            }
                            
                            
                        }
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.5)
                    
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                        .offset(y:-50)
                }
            }.navigationBarHidden(true)
        }   .edgesIgnoringSafeArea(.all)
    }
}
