//
//  TimelineCommentCell.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/7/21.
//

import SwiftUI

struct TimelineCommentCell: View {
    @ObservedObject var timelineViewModel: TimelineViewModel
    let timelineComment: TimelineCommentResult
    
    var body: some View {
        HStack{
            NavigationLink(destination: UserProfileView(userViewModel: UserViewModel.userVM, challengeViewModel: ChallengeViewModel.challengeVM, userId: timelineComment.userId).onAppear(){
                UserViewModel.userVM.getUser = nil
                ChallengeViewModel.challengeVM.usersChallengesActive.removeAll()
                ChallengeViewModel.challengeVM.usersChallenges.removeAll()
                ChallengeViewModel.challengeVM.usersAllChallenges.removeAll()
                ChallengeViewModel.challengeVM.usersChallengesFinished.removeAll()
                UserViewModel.userVM.getUser(id: timelineComment.userId) { result in
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
            AsyncImage(url: URL(string: timelineComment.profilePicture ?? "empty")) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 39))
            }
            .clipShape(Circle())
            .scaledToFill()
            .frame(width: 39, height: 39, alignment: .center)
            .clipped()
                           }
            VStack{
                VStack{
                    Text(timelineComment.fullName)
                        .font(Font.headline.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                    Text(DateConverter.convertTime(of: timelineComment.timestamp))
                        .font(Font.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 5)
                    Text(timelineComment.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                        .fixedSize(horizontal: false, vertical: true)
                }.background(Color("commentGray").opacity(0.5))
                    .cornerRadius(10, corners: [.topRight, .bottomLeft, .bottomRight])
                    .frame(width: 300)
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            
        }.frame(maxWidth: .infinity, alignment: .trailing)
        
    }
    
}


