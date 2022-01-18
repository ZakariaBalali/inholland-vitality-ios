//
//  UserProfileView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/30/21.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var challengeViewModel: ChallengeViewModel
    @State var userId: String
    @Environment(\.presentationMode) var presentationMode
    @State var isFollowPopupPresented: Bool = false

    var body: some View {
        if(userViewModel.getUser != nil){
            VStack{
                ZStack{
                    
                    VStack(spacing: 0){
                        ZStack{
                            Color("inhollandPink").edgesIgnoringSafeArea(.top)
                            VStack{
                                VStack{
                                    Text((userViewModel.getUser?.firstName ?? " " ) + " " + (userViewModel.getUser?.lastName ?? " "))
                                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                        .multilineTextAlignment(.leading)
                                    Text((userViewModel.getUser?.jobTitle ?? " ") + ", " + (userViewModel.getUser?.location ?? " "))
                                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                        .multilineTextAlignment(.leading)
                                    
                                }.frame(width: UIScreen.main.bounds.width / 2)
                            }.foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(20)
                        }
                        ZStack{
                            Color.white
                            VStack{
                                HStack{
                                    Text(userViewModel.getUser?.description ?? " ")
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.leading)
                                }.frame(width: UIScreen.main.bounds.width / 2)
                            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(20)

                            
                        }
                    }
                    
                    HStack{
                        VStack{
                            AsyncImage(url: URL(string: userViewModel.getUser?.profilePicture ?? "empty")) { image in
                                image.resizable()
                            } placeholder: {
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(Color.white)
                                .font(.system(size: 60))                    }
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Text("\(Text(String(userViewModel.getUser?.points ?? 0)).foregroundColor(Color("inhollandPink"))) \(Text(String(localized: "overview_points")))")
                                .font(Font.caption.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            if(userViewModel.getUser?.id == UserViewModel.userVM.userIdForProfile){
                                
                                NavigationLink(destination: UpdateProfileView(userViewModel: userViewModel).overlay(alignment: .top, content: {
                                    Color("inhollandPink")
                                        .background(.regularMaterial)
                                        .edgesIgnoringSafeArea(.top)
                                        .frame(height: 0)
                                })) {
                                    Text(String(localized: "profile_edit"))
                                }
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color("inhollandPink"))
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                
                            }
                            else{
                                if(userViewModel.isFollowing){
                                    Button(action: {
                                        self.isFollowPopupPresented = true
                                       }) {
                                            Text(String(localized: "user_profile_unfollow"))
                                            
                                        }
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color("inhollandPink"))
                                        .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                }else{
                                    Button(action: {
                                        userViewModel.changeFollowStatus(endpoint: .followUser(userViewModel.getUser?.id ?? " ", "true")) { result in
                                            switch result {
                                            case .success(_):
                                                break
                                            case.failure:
                                                break
                                                
                                            }
                                        }}) {
                                            Text(String(localized: "user_profile_follow"))
                                            
                                        }
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color("inhollandPink"))
                                        .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                }
                            }
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
                
                if challengeViewModel.usersChallengesActive.isEmpty {
                    Text("")
                        .onAppear(){
                            self.challengeViewModel.fetchUsersChallenges(id: userId) { result in
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
                            Text((userViewModel.getUser?.firstName ?? " ") + String(localized: "profile_active_activities"))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 5)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(challengeViewModel.usersChallengesActive) { challenge in
                                    NavigationLink(destination: FinishedChallengeDetailView(challengeViewModel: challengeViewModel, challengeId: challenge.id)) {
                                        FinishedChallengeCell(challengeViewModel: challengeViewModel, challenge: challenge)
                                    }.onAppear(){
                                        challengeViewModel.challenge = nil
                                    }
                                    .onAppear(){
                                        challengeViewModel.fetchUsersChallenges(id: userId) { result in
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
                                    .foregroundColor(.black)                    }
                            }
                        }
                    }.padding()
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.5)
                        .offset(y: 20)
                }
                VStack(spacing: 0){
                    if challengeViewModel.usersChallengesFinished.isEmpty {
                        Text(" ")
                            .onAppear(){
                                challengeViewModel.fetchUsersChallenges(id: userId) { result in
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
                                Text((userViewModel.getUser?.firstName ?? " ") + String(localized: "profile_trophies"))
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 5)
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(challengeViewModel.usersChallengesFinished) { challenge in
                                        NavigationLink(destination: FinishedChallengeDetailView(challengeViewModel: challengeViewModel, challengeId: challenge.id)) {
                                            FinishedChallengeCell(challengeViewModel: challengeViewModel, challenge: challenge).onAppear(){
                                                challengeViewModel.challenge = nil
                                            }
                                        }
                                        
                                        .foregroundColor(.black)                    }
                                }
                            }
                        }.padding()
                            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.5)
                            .offset(y: -30)
                        
                    }
                }.offset(y: -10)
                
            } .alert(isPresented: $isFollowPopupPresented) {
                Alert(title: Text(String(localized:"unfollow")), message: Text(String(localized: "unfollow_message")), primaryButton: .destructive(Text(String(localized: "i_am_sure"))) {
                    userViewModel.changeFollowStatus(endpoint: .followUser(userViewModel.getUser?.id ?? " ", "false")) { result in
                        switch result {
                        case .success(_):
                            break
                        case.failure:
                            break
                            
                        }
                    }         },
                      secondaryButton: .cancel()
                )
            }
            .onAppear() {
                self.userViewModel.getUser(id: userId) { result in
                    switch result {
                    case .success(_):
                        self.challengeViewModel.fetchUsersChallenges(id: userId) { result in
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
        else{
            VStack{
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
                ScrollView{
                    ProgressView(String(localized: "loading_placeholder"))
                }
                .onAppear() {
                    self.userViewModel.getUser(id: userId) { result in
                        switch result {
                        case .success(_):
                            break
                        case .failure(_):
                            self.userViewModel.getUser(id: userId) { result in
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
                
                
            }
        }
    }
}
