//
//  NotificationDetailView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/8/22.
//

import Foundation
import SwiftUI
struct NotificationDetailView: View {
    @ObservedObject var timelineViewModel: TimelineViewModel
    @ObservedObject var userViewModel: UserViewModel
    let timelinePostId: String
    @State var iLikedPost: Bool = false
    @State var likeCounter: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @State var isRequestErrorViewPresented: Bool = false
    
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
        if(timelineViewModel.timelinepost == nil){
            
            ScrollView{
                Text(String(localized: "timeline_cannot_find"))
                    .foregroundColor(Color.gray)
            }
            
            .onAppear() {
                self.timelineViewModel.getPost(id: timelinePostId) { result in
                    switch result {
                    case .success(_):
                        break;
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
            
        }else{
            ScrollView{
                VStack{
                    
                    HStack{
                        NavigationLink(destination: UserProfileView(userViewModel: userViewModel, challengeViewModel: ChallengeViewModel.challengeVM, userId: timelineViewModel.timelinepost?.userId ?? " ").overlay(alignment: .top, content: {
                            Color("inhollandPink")
                                .background(.regularMaterial)
                                .edgesIgnoringSafeArea(.top)
                                .frame(height: 0)
                        })) {
                            HStack{
                                AsyncImage(url: URL(string: timelineViewModel.timelinepost?.profilePicture ?? "empty")) { image in
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
                                
                                
                                VStack{
                                    Text(timelineViewModel.timelinepost?.fullName ?? " ")
                                        .font(Font.headline.weight(.bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                    Text(DateConverter.convertTime(of: timelineViewModel.timelinepost?.publishDate ?? " "))
                                        .font(Font.footnote)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(Color.gray)
                                    
                                }
                                
                            }
                            .padding(10)
                        }
                        .frame(maxWidth: .infinity,  alignment: .leading)
                        
                        Spacer()
                        if(timelineViewModel.timelinepost?.userId == UserViewModel.userVM.userIdForProfile){
                            Button(action: {
                                self.isRequestErrorViewPresented = true
                            }) {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(Color.red)
                                    .offset(x: -10)
                            }
                            
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Text(timelineViewModel.timelinepost?.text ?? " ")
                        .offset(y:-20)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if(timelineViewModel.timelinepost?.imageUrl != nil){
                        AsyncImage(url: URL(string: timelineViewModel.timelinepost?.imageUrl ?? "empty")) { image in
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
                        NavigationLink(destination: LikersView(userViewModel: userViewModel, id: timelineViewModel.timelinepost?.id ?? " ").overlay(alignment: .top, content: {
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
                    if (timelineViewModel.timelinepost?.countOfComments ?? 0 > 1){
                        Text(String(timelineViewModel.timelinepost?.countOfComments ?? 0) + " " + String(localized: "timeline_comments"))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(10)
                            .foregroundColor(Color.black)
                    }
                    else if(timelineViewModel.timelinepost?.countOfComments == 1){
                        Text(String(timelineViewModel.timelinepost?.countOfComments ?? 0) + " " + String(localized: "timeline_comment"))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(10)
                            .foregroundColor(Color.black)
                    }
                    else{
                        //niks
                    }
                }.overlay(VStack{Divider().offset(x: 0, y: 15)})
                HStack{
                    if (iLikedPost == false){
                        HStack{
                            Button(action: {iLikedPost.toggle()
                                likeCounter += 1
                                timelineViewModel.likePost(timelinePost: timelineViewModel.timelinepost!) { result in
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
                                NavigationLink(destination: CommentOnPostView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, timelinePost: timelineViewModel.timelinepost? .id ?? " " ).overlay(alignment: .top, content: {
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
                                timelineViewModel.unlikePost(timelinePost: timelineViewModel.timelinepost!) { result in
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
                                NavigationLink(destination: CommentOnPostView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, timelinePost: timelineViewModel.timelinepost?.id ?? " ").overlay(alignment: .top, content: {
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
                    iLikedPost = timelineViewModel.timelinepost?.iLikedPost ?? false
                    likeCounter = timelineViewModel.timelinepost?.countOfLikes ?? 0
                }
                .alert(isPresented: $isRequestErrorViewPresented) {
                    Alert(title: Text(String(localized:"delete_message")), message: Text(String(localized: "confirmation_delete")), primaryButton: .destructive(Text(String(localized: "i_am_sure"))) {
                        timelineViewModel.deletePost(id: timelinePostId) { result in
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
                            timelineViewModel.fetchTimelineComments(timelinePost: timelineViewModel.timelinepost?.id ?? " ") { result in
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
                        if(timelineViewModel.timelinepost?.countOfComments != timelineViewModel.timelineComments.count){
                            Button(action:{
                                timelineViewModel.fetchTimelineComments(timelinePost: timelineViewModel.timelinepost?.id ?? "") { result in
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
                        }                   }
                }
            }.onAppear() {
                self.timelineViewModel.getPost(id: timelinePostId) { result in
                    switch result {
                    case .success(_):
                        timelineViewModel.fetchTimelineComments(timelinePost: timelineViewModel.timelinepost?.id ?? " ") { result in
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
}

