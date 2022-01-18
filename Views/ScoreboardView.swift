//
//  ScoreboardView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/1/22.
//

import SwiftUI

struct ScoreboardView: View {
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top){
            VStack(spacing:0){
                
                HStack{
                    Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .padding(.leading, 10)
                        HStack{
                            Text(String(localized: "back_button"))
                                .frame(height: 40)
                                .foregroundColor(Color.white)
                            
                            
                        }.padding(10)
                        
                        
                    }
                }.frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                    .background(Color("inhollandPink"))
                    .offset(y: -3)
                
                
            }.navigationBarHidden(true)
        }
        
        VStack(spacing: 0){
            if userViewModel.scoreboard.isEmpty {
                ScrollView{
                    ProgressView(String(localized: "loading_placeholder"))
                }
                .onAppear(){
                    userViewModel.getScoreboard { result in
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
                        Text(String(localized: "scoreboard_caption"))
                            .frame(width: UIScreen.main.bounds.width - 30,  alignment: .center)
                            .padding(10)
                        ForEach(userViewModel.scoreboard.indices,id:\.self) { index in
                            NavigationLink(destination: UserProfileView(userViewModel: userViewModel, challengeViewModel: ChallengeViewModel.challengeVM, userId: userViewModel.scoreboard[index].id).onAppear(){
                                userViewModel.getUser = nil
                                ChallengeViewModel.challengeVM.usersChallengesActive.removeAll()
                                ChallengeViewModel.challengeVM.usersChallenges.removeAll()
                                ChallengeViewModel.challengeVM.usersAllChallenges.removeAll()
                                ChallengeViewModel.challengeVM.usersChallengesFinished.removeAll()
                                self.userViewModel.getUser(id: userViewModel.scoreboard[index].id) { result in
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
                                ScoreboardCell(scoreboard: userViewModel.scoreboard[index], position: index)
                                    .frame(width: UIScreen.main.bounds.width - 30,  alignment: .center)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                    .shadow(color: Color.black, radius: 3, x: 0, y: 0)
                                    .padding(.bottom, 8)
                            }
                        }
                        Text(" ")
                            .onAppear(){
                                DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                                    userViewModel.getScoreboard { result in
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
                        .foregroundColor(.black)                    } .frame(width: UIScreen.main.bounds.width,  alignment: .center)
                        .padding(.top, 10)
                    
                }
                
            }
        }.padding(.top, 0)
            
        
    }
}
