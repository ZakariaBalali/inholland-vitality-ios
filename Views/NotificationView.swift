//
//  NotificationView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/26/21.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var timelineViewModel: TimelineViewModel
    var body: some View {
        
        VStack(spacing: 0){
            if userViewModel.notifications.isEmpty {
                VStack{
                    Image(systemName: "bell.fill")
                        .font(.system(size: 39))
                        .foregroundColor(Color("inhollandPink"))
                    Text(String(localized: "notification_empty"))
                        .foregroundColor(Color.black)
                }
                .onAppear(){
                    userViewModel.fetchNotifications { result in
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
                        ForEach(userViewModel.notifications) { notification in
                            
                            if(notification.timelinePostId != nil){
                                
                                NavigationLink(destination: NotificationDetailView(timelineViewModel: timelineViewModel,  userViewModel: userViewModel, timelinePostId: notification.timelinePostId ?? " ")  .onAppear {
                                    self.timelineViewModel.timelinepost = nil
                                    timelineViewModel.timelineComments.removeAll()
                                    timelineViewModel.offsetComments = 0

                                }.overlay(alignment: .top, content: {
                                    Color("inhollandPink")
                                        .background(.regularMaterial)
                                        .edgesIgnoringSafeArea(.top)
                                        .frame(height: 0)
                                })){
                                    NotificationCell(notification: notification)
                                        .overlay(VStack{Divider().offset(x: 0, y: 30)})
                                        .foregroundColor(.black)
                                        .padding(.bottom, 10)
                                }
                            }else if(notification.timelinePostId == nil && notification.notificationType == 3){
                                NavigationLink(destination: UserProfileView(userViewModel: userViewModel, challengeViewModel: ChallengeViewModel.challengeVM, userId: notification.userId).onAppear(){
                                    userViewModel.getUser = nil
                                    ChallengeViewModel.challengeVM.usersChallengesActive.removeAll()
                                    ChallengeViewModel.challengeVM.usersChallenges.removeAll()
                                    ChallengeViewModel.challengeVM.usersAllChallenges.removeAll()
                                    ChallengeViewModel.challengeVM.usersChallengesFinished.removeAll()
                                    self.userViewModel.getUser(id: notification.userId) { result in
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
                                    NotificationCell(notification: notification)
                                        .overlay(VStack{Divider().offset(x: 0, y: 30)})
                                        .foregroundColor(.black)
                                        .padding(.bottom, 10)
                                }
                                
                            }
                            else if(notification.timelinePostId == nil && notification.notificationType == 4){
                                NavigationLink(destination: FinishedChallengeDetailView(challengeViewModel: ChallengeViewModel.challengeVM, challengeId: notification.challengeId ?? " ").onAppear(){
                                    ChallengeViewModel.challengeVM.challenge = nil
                                    ChallengeViewModel.challengeVM.getChallenge(id: notification.challengeId ?? " ") { result in
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
                                }) {
                                NotificationCell(notification: notification)
                                    .overlay(VStack{Divider().offset(x: 0, y: 30)})
                                    .foregroundColor(.black)
                                    .padding(.bottom, 10)
                                }
                            
                        
                            }
                        }
                        Text(" ")
                            .onAppear(){
                                DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                                    userViewModel.fetchNotifications { result in
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
