//
//  LikersView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/1/22.
//

import SwiftUI

struct LikersView: View {
    @ObservedObject var userViewModel: UserViewModel
    var id: String
    var body: some View {
        
        VStack(spacing: 0){
            if userViewModel.likers.isEmpty {
                ProgressView(String(localized: "loading_placeholder"))
                    .onAppear(){
                        userViewModel.getLikers(id: id) { result in
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
                ScrollView {
                    LazyVStack {
                        ForEach(userViewModel.likers) { liker in
                            NavigationLink(destination: UserProfileView(userViewModel: userViewModel, challengeViewModel: ChallengeViewModel.challengeVM, userId: liker.userId).onAppear(){
                                userViewModel.getUser = nil
                                ChallengeViewModel.challengeVM.usersChallengesActive.removeAll()
                                ChallengeViewModel.challengeVM.usersChallenges.removeAll()
                                ChallengeViewModel.challengeVM.usersAllChallenges.removeAll()
                                ChallengeViewModel.challengeVM.usersChallengesFinished.removeAll()
                                self.userViewModel.getUser(id: liker.userId) { result in
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
                            }.overlay(alignment: .top, content: {
                                Color("inhollandPink")
                                    .background(.regularMaterial)
                                    .edgesIgnoringSafeArea(.top)
                                    .frame(height: 0)
                            })) {
                                LikersCell(user: liker)
                                    .overlay(VStack{Divider().offset(x: 0, y: 22)})
                                    .foregroundColor(.black)
                            }
                           
                        }
                        .foregroundColor(.black)                    } .frame(width: UIScreen.main.bounds.width,  alignment: .center)
                        .padding(.top, 10)
                }
                Text(" ")
                    .onAppear(){
                        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                            userViewModel.getLikers(id: id) { result in
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
                    }
                
            }
        }.padding(.top, 0)
    }
}
