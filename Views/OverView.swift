//
//  OverView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import SwiftUI

struct OverView: View {
    @ObservedObject var challengeViewModel: ChallengeViewModel
    @ObservedObject var userViewModel: UserViewModel
    var body: some View {
        
        ZStack{
            VStack(spacing: 0) {
                ZStack{
                    VStack(spacing: 0){
                        TopBarOverView(userViewModel: userViewModel, user: userViewModel.user ?? UserResponse(id: " ", firstName: " ", lastName: " ", jobTitle: " ", location: " ", description: " ", challenges: [Challenge(id: " ", progress: 0)], followers: [Followers(id: " ")], profilePicture: " ", points: 0, following: false))
                        VStack{
                            VStack{
                                if challengeViewModel.challengesActive.isEmpty {
                                    VStack{
                                        Image("shoe_icon_pink")
                                            .resizable()
                                            .frame(width: CGFloat(40), height: CGFloat(40))
                                        Text(NSLocalizedString("no_active_activities", comment: ""))
                                    }                                   
                            } else {
                                        HStack{
                                            Image("shoe_icon_pink")
                                            Text(NSLocalizedString("active_activities", comment: ""))
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.top, 5)
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack {
                                                ForEach(challengeViewModel.challengesActive) { challenge in
                                                    
                                                    ChallengeCell(challengeViewModel: challengeViewModel, challenge: challenge)
                                                    
                                                }
                                                
                                            }
                                        }
                                    }
                            }
                        }.padding()
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
                            if challengeViewModel.challenges.isEmpty {
                                VStack{
                                    Image(systemName: "lightbulb")
                                        .foregroundColor(Color("inhollandPink"))
                                        .font(.system(size: CGFloat(40)))
                                    Text(NSLocalizedString("no_activities_available", comment: ""))
                                }
                              
                            } else {
                                HStack{
                                    Image(systemName: "lightbulb").foregroundColor(Color("inhollandPink"))
                                    Text(NSLocalizedString("discover_activities", comment: ""))
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 5)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(challengeViewModel.challenges) { challenge in
                                            
                                            ChallengeCell(challengeViewModel: challengeViewModel, challenge: challenge)
                                            
                                            .foregroundColor(.black)                    }
                                    }
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
