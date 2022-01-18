//
//  ChallengeDetailView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import SwiftUI

struct TimelineDetailView: View {
    @ObservedObject var timelineViewModel: TimelineViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var userViewModel: UserViewModel
    let timelinePost: TimelineResult
    @State var iLikedPost: Bool = false
    @State var likeCounter: Int = 0
    @State var isRequestErrorViewPresented: Bool = false
    
    var body: some View {
        ScrollView{
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
                            AsyncImage(url: URL(string: timelinePost.profilePicture ?? "empty")) { image in
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
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                            Text(DateConverter.convertTime(of: timelinePost.publishDate))
                                .font(Font.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color.gray)
                            
                        }
                        
                    }
                    .padding(10)
                    
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.3,  alignment: .leading)
                    
                    Spacer()
                    if(timelinePost.userId == UserViewModel.userVM.userIdForProfile){
                        Button(action: {
                            self.isRequestErrorViewPresented = true
                        }) {
                            Image(systemName: "trash.fill")
                                .foregroundColor(Color.red)
                                .offset(x: -10)
                        }
                        
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Text(timelinePost.text)
                    .offset(y:-20)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                if(timelinePost.imageUrl != nil){
                    AsyncImage(url: URL(string: timelinePost.imageUrl ?? "empty")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.white
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }
            HStack{
                if(likeCounter > 0){
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
                            
                            Text(String(likeCounter))
                                .foregroundColor(Color.black)
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                    }
                }
                else{HStack{
                    Image("thumbsup_icon")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                    
                    Text(String(likeCounter))
                        .foregroundColor(Color.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                }
                if (timelinePost.countOfComments > 1){
                    Text(String(timelinePost.countOfComments) + " " + String(localized: "timeline_comments"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(10)
                        .foregroundColor(Color.black)
                }
                else if(timelinePost.countOfComments == 1){
                    Text(String(timelinePost.countOfComments) + " " + String(localized: "timeline_comment"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(10)
                        .foregroundColor(Color.black)
                }
                else{
                    //niks
                }
            }.overlay(VStack{Divider().offset(x: 0, y: 18)})
            HStack{
                if (iLikedPost == false){
                    HStack{
                        Button(action: {iLikedPost.toggle()
                            likeCounter += 1
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
                                    .foregroundColor(Color.black)
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
                                    .foregroundColor(Color.black)
                            }
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 10)
                        
                    }.frame(height: 50)
                    
                }
                else{
                    HStack{
                        Button(action: {iLikedPost.toggle()
                            likeCounter -= 1
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
                                Text(String(localized: "timeline_like"))
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
                                Text(String(localized: "timeline_comment_on_post"))
                                    .foregroundColor(Color.black)
                            }
                            
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 10)
                        
                    }.frame(height: 50)
                }
                
                
            }
            .onAppear {
                iLikedPost = timelinePost.iLikedPost
                likeCounter = timelinePost.countOfLikes
            }
            .alert(isPresented: $isRequestErrorViewPresented) {
                Alert(title: Text(String(localized:"delete_message")), message: Text(String(localized: "confirmation_delete")), primaryButton: .destructive(Text(String(localized: "i_am_sure"))) {
                    timelineViewModel.deletePost(id: timelinePost.id) { result in
                        switch result {
                        case .success(_):
                            self.presentationMode.wrappedValue.dismiss()
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
                    }                },
                      secondaryButton: .cancel()
                )
            }
            
            if timelineViewModel.timelineComments.isEmpty {
                Text(String(localized: "no_comments"))
                    .onAppear(){
                        timelineViewModel.fetchTimelineComments(timelinePost: timelinePost.id) { result in
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
                
                LazyVStack {
                    ForEach(timelineViewModel.timelineComments) { timelineComment in
                        
                        TimelineCommentCell(timelineViewModel: timelineViewModel, timelineComment: timelineComment)
                            .padding(.leading, 10)
                        
                    }.foregroundColor(.black)  
                    if(timelinePost.countOfComments != timelineViewModel.timelineComments.count){
                        Button(action:{
                            timelineViewModel.fetchTimelineComments(timelinePost: timelinePost.id) { result in
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
                        }){
                            Text(String(localized:"load_more"))
                                .foregroundColor(Color.blue)
                        }
                    }
                }.padding(.top, 10)
                    .overlay(VStack{Divider().offset(x: 0, y: -45)})
            }
            
        }}
}

