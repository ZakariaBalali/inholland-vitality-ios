//
//  ProfileView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/6/21.
//

import SwiftUI
import CachedAsyncImage
struct ProfileView: View {
    @ObservedObject var challengeViewModel: ChallengeViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
       
        VStack{
            ZStack{
                VStack(spacing: 0){
                    ZStack{
                        Color("inhollandPink").edgesIgnoringSafeArea(.top)
                        VStack{
                            VStack{
                                Text((userViewModel.user?.firstName ?? " " ) + " " + (userViewModel.user?.lastName ?? " "))
                                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                    .multilineTextAlignment(.leading)
                                Text((userViewModel.user?.jobTitle ?? " ") + ", " + (userViewModel.user?.location ?? " "))
                                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                    .multilineTextAlignment(.leading)
                                
                            }.frame(width: UIScreen.main.bounds.width / 2)
                        }.foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(10)
                    }
                    ZStack{
                        Color.white
                        VStack{
                            HStack{
                                Text(userViewModel.user?.description ?? " ")
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.leading)
                            }.frame(width: UIScreen.main.bounds.width / 2)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .offset(y: 10)
                            .padding(10)

                        
                    }
                }
                
                HStack{
                    VStack{
                        AsyncImage(url: URL(string: userViewModel.user?.profilePicture ?? "empty")) { image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(Color.white)
                            .font(.system(size: 60))                    }
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Text("\(Text(String(userViewModel.user?.points ?? 0)).foregroundColor(Color("inhollandPink"))) \(Text(String(localized: "overview_points")))")
                            .font(Font.caption.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        NavigationLink(destination: UpdateProfileView(userViewModel: userViewModel).overlay(alignment: .top, content: {
                            Color("inhollandPink")
                                .background(.regularMaterial)
                                .edgesIgnoringSafeArea(.top)
                                .frame(height: 0)
                        })) {
                            Text(String(localized: "profile_edit"))                       }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color("inhollandPink"))
                        .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                    }
                    VStack{
                        
                        Text(" ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.headline.weight(.light))
                            .foregroundColor(Color.black)
                    }
                    
                }
                
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            VStack(spacing: 0){
                if challengeViewModel.challengesActive.isEmpty {
                   
                } else {
                    VStack{
                        HStack{
                            Text((userViewModel.user?.firstName ?? " ") + String(localized: "profile_active_activities"))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 5)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(challengeViewModel.challengesActive) { challenge in
                                    NavigationLink(destination: ChallengeDetailView(challengeViewModel: challengeViewModel, challengeResult: challenge)) {
                                        FinishedChallengeCell(challengeViewModel: challengeViewModel, challenge: challenge)
                                    }
                                 
                                    .foregroundColor(.black)                    }
                            }
                        }
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.5)
                }
                if challengeViewModel.challengesFinished.isEmpty {
                    Text(" ")
                        .onAppear(){
                            challengeViewModel.fetchChallenges { result in
                                switch result {
                                case .success(_):
                                    break
                                case .failure(let error):
                                    switch error {
                                    case .urlError(let urlError):
                                        print("URL Error: \(String(describing: urlError))")
                                    case .decodingError(let decodingError):
                                        print("Decoding Error: \(String(describing: decodingError))")
                                    case .genericError(let error):
                                        print("Error: \(String(describing: error))")
                                    }
                                }
                            }
                        }
                } else {
                    VStack{
                        HStack{
                            Text((userViewModel.user?.firstName ?? " ") + String(localized: "profile_trophies"))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 5)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(challengeViewModel.challengesFinished) { challenge in
                                    NavigationLink(destination: ChallengeDetailView(challengeViewModel: challengeViewModel, challengeResult: challenge)) {
                                        FinishedChallengeCell(challengeViewModel: challengeViewModel, challenge: challenge)
                                    }
                                  
                                    .foregroundColor(.black)                    }
                            }
                        }
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.5)
                        .offset(y: -30)
                    
                }
            }.offset(y: -10)
        }
    }
}

