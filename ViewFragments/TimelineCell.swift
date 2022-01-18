//
//  ChallengeCell.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import SwiftUI
import CachedAsyncImage
struct TimelineCell: View {
    @ObservedObject var timelineViewModel: TimelineViewModel
    @ObservedObject var userViewModel: UserViewModel
    let timelinePost: TimelineResult

    @State var iLikedPost: Bool = false
    
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    HStack{

                    NavigationLink(destination: UserProfileView(userViewModel: userViewModel, challengeViewModel: ChallengeViewModel.challengeVM, userId: timelinePost.userId).onAppear(){
                        userViewModel.getUser = nil
                        ChallengeViewModel.challengeVM.usersChallengesActive.removeAll()
                        ChallengeViewModel.challengeVM.usersChallenges.removeAll()
                        ChallengeViewModel.challengeVM.usersAllChallenges.removeAll()
                        ChallengeViewModel.challengeVM.usersChallengesFinished.removeAll()
                        self.userViewModel.getUser(id: timelinePost.userId) { result in
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
                            CachedAsyncImage(url: URL(string: timelinePost.profilePicture ?? "empty")) { image in
                                image.resizable()
                            } placeholder: {
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 39))
                            }
                            .clipShape(Circle())
                            .scaledToFill()
                            .clipped()
                            .frame(width: 39, height: 39, alignment: .center)
                            
                    }
                            VStack{
                                Text(timelinePost.fullName)
                                    .font(Font.headline.weight(.bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                Text(DateConverter.convertTime(of: timelinePost.publishDate))
                                    .font(Font.footnote)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color.gray)
                                
                            }
                            
                        }
                        .padding(10)
                    
                    .frame(maxWidth: .infinity,  alignment: .leading)
                    
                    Spacer()
                    Text(" ")
                }.frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: TimelineDetailView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, timelinePost: timelinePost).onAppear(){
                    timelineViewModel.offsetComments = 0
                    timelineViewModel.timelineComments.removeAll()
                }.overlay(alignment: .top, content: {
                    Color("inhollandPink")
                        .background(.regularMaterial)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 0)
                }))
                {
                    VStack{
                        Text(timelinePost.text)
                            .offset(y:-20)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                        
                        if(timelinePost.imageUrl != nil){
                                                  CachedAsyncImage(url: URL(string: timelinePost.imageUrl ?? "empty")) { image in
                                                      image.resizable()
                                                  } placeholder: {
                                                      ProgressView()
                                                  }
                                                  .aspectRatio(contentMode: .fill)
                                                  .frame(maxWidth: .infinity, alignment: .center)
                                              }
                    }
                }
            }
            HStack{
                if(timelinePost.countOfLikes > 0){
                    NavigationLink(destination: LikersView(userViewModel: userViewModel, id: timelinePost.id ).onAppear{
                        userViewModel.likers.removeAll()
                        userViewModel.offsetLikers = 0
                    }.overlay(alignment: .top, content: {
                        Color("inhollandPink")
                            .background(.regularMaterial)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
                    })) {
                        HStack{
                            Image("thumbsup_icon")
                                .resizable()
                                .frame(width: 15.0, height: 15.0)
                            
                            Text(String(timelinePost.countOfLikes))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                    }
                }
                else{HStack{
                    Image("thumbsup_icon")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                    
                    Text(String(timelinePost.countOfLikes))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                }
                if (timelinePost.countOfComments > 1){
                    NavigationLink(destination: TimelineDetailView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, timelinePost: timelinePost).onAppear(){
                        timelineViewModel.offsetComments = 0
                        timelineViewModel.timelineComments.removeAll()
                    }.overlay(alignment: .top, content: {
                        Color("inhollandPink")
                            .background(.regularMaterial)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
                    }))
                    {
                        Text(String(timelinePost.countOfComments) + " " + String(localized: "timeline_comments"))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(10)
                    }
                }
                else if(timelinePost.countOfComments == 1){
                    NavigationLink(destination: TimelineDetailView(timelineViewModel: timelineViewModel,  userViewModel: userViewModel, timelinePost: timelinePost).onAppear(){
                        timelineViewModel.offsetComments = 0
                        timelineViewModel.timelineComments.removeAll()
                    }.overlay(alignment: .top, content: {
                        Color("inhollandPink")
                            .background(.regularMaterial)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
                    })){
                        Text(String(timelinePost.countOfComments) + " " + String(localized: "timeline_comment"))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(10)
                    }
                }
                else{
                    
                }
            }.overlay(VStack{Divider().offset(x: 0, y: 15)})
            HStack{
                if (iLikedPost == false){
                    HStack{
                        Button(action: {iLikedPost.toggle()
                            timelinePost.countOfLikes += 1
                            timelineViewModel.likePost(timelinePost: timelinePost) { result in
                                switch result {
                                case .success(_):
                                    break
                                case.failure(let error):
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
                        }) {
                            HStack{
                                Image("thumbsup_icon_white")
                                    .padding(.horizontal, 2)
                                Text(String(localized: "timeline_like"))
                            }.padding(.leading, 10)
                        }
                        
                        HStack{
                            NavigationLink(destination: CommentOnPostView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, timelinePost: timelinePost.id).overlay(alignment: .top, content: {
                                Color("inhollandPink")
                                    .background(.regularMaterial)
                                    .edgesIgnoringSafeArea(.top)
                                    .frame(height: 0)
                            })){
                                Image("message_icon")
                                    .padding(.horizontal, 2)
                                Text(String(localized: "timeline_comment_on_post"))
                            }
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 10)
                        
                    }.frame(height: 50)
                    
                }
                else{
                    HStack{
                        Button(action: {iLikedPost.toggle()
                            timelinePost.countOfLikes -= 1
                            timelineViewModel.unlikePost(timelinePost: timelinePost) { result in
                                switch result {
                                case .success(_):
                                    break
                                case.failure(let error):
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
                        }) {
                            HStack{
                                Image("thumbsup_icon_pink")
                                    .padding(.horizontal, 2)
                                Text("Vind ik leuk")
                                    .foregroundColor(Color("inhollandPink"))
                                
                            }.padding(.leading, 10)
                        }
                        
                        HStack{
                            NavigationLink(destination: CommentOnPostView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, timelinePost: timelinePost.id).overlay(alignment: .top, content: {
                                Color("inhollandPink")
                                    .background(.regularMaterial)
                                    .edgesIgnoringSafeArea(.top)
                                    .frame(height: 0)
                            })){
                                Image("message_icon")
                                    .padding(.horizontal, 2)
                                Text("Reageren")
                            }
                            
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 10)
                        
                    }.frame(height: 50)
                }
                
                
            }
            .onAppear {
                iLikedPost = timelinePost.iLikedPost
            }
        }
        
        
        
    }
}

