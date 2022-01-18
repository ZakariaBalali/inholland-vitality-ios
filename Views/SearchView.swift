//
//  SearchView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/13/21.
//

import SwiftUI
import SwiftUIX
struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var searchQuery: String = ""
    @ObservedObject var userViewModel: UserViewModel
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
                    }
                    
                    HStack{
                        CocoaTextField("  " + String(localized: "timeline_search_placeholder"), text: $searchQuery, onCommit: {
                            userViewModel.search.removeAll()
                            userViewModel.offsetSearch = 0
                            userViewModel.searchUser(query: searchQuery) { result in
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
                            
                            
                        }).isFirstResponder(true)
                            .frame(height: 40)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius:20))
                        
                    }.padding(10)
                    
                }.frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                    .background(Color("inhollandPink"))
                    .offset(y: -3)
                
                if(userViewModel.search.isEmpty && userViewModel.hasSearched){
                    Text("Geen resultaten")
                        .foregroundColor(Color.gray)
                }
                ScrollView {
                    LazyVStack {
                        ForEach(userViewModel.search) { user in
                            NavigationLink(destination: UserProfileView(userViewModel: userViewModel, challengeViewModel: ChallengeViewModel.challengeVM, userId: user.id).onAppear(){
                                userViewModel.getUser = nil
                                ChallengeViewModel.challengeVM.usersChallengesActive.removeAll()
                                ChallengeViewModel.challengeVM.usersChallenges.removeAll()
                                ChallengeViewModel.challengeVM.usersAllChallenges.removeAll()
                                ChallengeViewModel.challengeVM.usersChallengesFinished.removeAll()
                                self.userViewModel.getUser(id: user.id) { result in
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
                                SearchCell(userViewModel: userViewModel, user: user)
                                    .overlay(VStack{Divider().offset(x: 0, y: 22)})
                                .foregroundColor(.black)                    }
                        }
                        Text(" ")
                            .onAppear(){
                                DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                                    userViewModel.searchUser(query: searchQuery) { result in
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
                }.padding(.top, 10)
                    
                
                
            }.navigationBarHidden(true)
        }
    }
}
