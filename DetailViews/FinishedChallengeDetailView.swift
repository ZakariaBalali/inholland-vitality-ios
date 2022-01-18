//
//  FinishedChallengeDetailView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/11/22.
//

import SwiftUI
import AVKit

struct FinishedChallengeDetailView: View {
    @ObservedObject var challengeViewModel: ChallengeViewModel
    @Environment(\.presentationMode) var presentationMode
    let challengeId: String
    @State var isRequestErrorViewPresented: Bool = false
    
    
    var body: some View {
        if(challengeViewModel.challenge == nil){
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
                self.challengeViewModel.getChallenge(id: challengeId) { result in
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
        }
        else{
            
            ScrollView{
                ZStack(alignment: .bottomLeading){
                    AsyncImage(url: URL(string: challengeViewModel.challenge?.imageLink ?? "empty")) { image in
                        image.resizable()
                    } placeholder: {
                        Image("challenge_placeholder")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .frame(width: UIScreen.main.bounds.width,  alignment: .center)
                            
                        
                    }
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.top)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))

                    .frame(width: UIScreen.main.bounds.width,  alignment: .center)
                    VStack{
                        HStack{
                            if challengeViewModel.challenge?.challengeType == 1{
                                Text(String(localized: "challenge_type_exercise"))
                                    .fontWeight(.bold)
                                    .font(.system(size: 25))
                                    .foregroundColor(Color("challengeYellow"))
                                
                            }
                            else if challengeViewModel.challenge?.challengeType == 2{
                                Text(String(localized: "challenge_type_diet"))
                                    .fontWeight(.bold)
                                    .font(.system(size: 25))
                                    .foregroundColor(Color("challengeYellow"))
                            }
                            else if challengeViewModel.challenge?.challengeType == 3{
                                Text(String(localized: "challenge_type_mind"))
                                    .fontWeight(.bold)
                                    .font(.system(size: 25))
                                    .foregroundColor(Color("challengeYellow"))
                                
                            }
                            
                            Text("Start: " + DateConverter.convertTimeDate(of: challengeViewModel.challenge?.startDate ?? " "))
                                .offset(y:1)
                                .font(.system(size: 15))
                                .foregroundColor(Color.white)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        Text(challengeViewModel.challenge?.title ?? " ")
                            .foregroundColor(Color.white)
                            .font(Font.title.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding(10)
                }
                Text("\(Text(String(localized: "challenge_detail_earn"))) \(Text(String(challengeViewModel.challenge?.points ?? 0)).foregroundColor(Color("inhollandPink"))) \(Text(String(localized: "challenge_detail_points")))")
                    .font(Font.headline.weight(.bold))
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text(challengeViewModel.challenge?.description ?? " ")
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if(challengeViewModel.challenge?.videoLink != nil){
                    VideoPlayer(player: AVPlayer(url:  URL(string: challengeViewModel.challenge?.videoLink ?? " ")!))
                        .frame(width: UIScreen.main.bounds.width - 30 ,height: 200, alignment: .center)
                }
                
                if(challengeViewModel.challenge?.challengeProgress == 0 || challengeViewModel.challenge?.challengeProgress == 3){
                    
                    
                    Button(action: {
                        challengeViewModel.subscribeToChallenge(challenge: challengeViewModel.challenge?.id ?? " ") { result in
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
                        }
                    }) {
                        Text("START ACTIVITEIT")
                    }.frame(maxWidth: UIScreen.main.bounds.width - 30 , minHeight:50)
                        .foregroundColor(.white)
                    
                        .background(Color("inhollandPink"))
                        .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                        .padding(.top, 20)
                    
                    Text(String(challengeViewModel.challenge?.totalSubscribers ?? 0) + " " + String(localized: "colleagues_participating"))
                        .font(Font.footnote)

                    VStack{
                        if(challengeViewModel.challenges.count > 1){
                        HStack{
                            Image(systemName: "lightbulb").foregroundColor(Color("inhollandPink"))
                            Text(NSLocalizedString("discover_activities", comment: ""))                              }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 5)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(challengeViewModel.challenges) { challenge in
                                    if(challengeId != challenge.id){
                                    ChallengeCell(challengeViewModel: challengeViewModel, challenge: challenge)
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
                                    .foregroundColor(.black)                    }
                                }
                            }
                        }
                    }  .padding()
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3.5)
                    
                        .background(Color.white)
                }
                else if(challengeViewModel.challenge?.challengeProgress == 1){
                    HStack{
                        
                        Button(action: {
                            self.isRequestErrorViewPresented = true
                        }) {
                            Text("STOP ACTIVITEIT")
                        }.frame(maxWidth: .infinity, minHeight:35)
                            .foregroundColor(.white)
                        
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        
                        Button(action: {
                            challengeViewModel.updateChallenge(challenge: challengeViewModel.challenge!, progressType: 2) { result in
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
                            }
                        }) {
                            Text("VOLTOOI ACTIVITEIT")
                        }.frame(maxWidth: .infinity, minHeight:35)
                            .foregroundColor(.white)
                        
                            .background(Color("inhollandPink"))
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        
                        
                        
                    }.frame(width: UIScreen.main.bounds.width - 30,  alignment: .center)
                }
                else{
                    
                }
                
            }.edgesIgnoringSafeArea(.top)
                .alert(isPresented: $isRequestErrorViewPresented) {
                    Alert(title: Text(String(localized: "stop_activity")), message: Text(String(localized: "confirmation_stop")), primaryButton: .destructive(Text(String(localized: "i_am_sure"))) {
                        challengeViewModel.updateChallenge(challenge: challengeViewModel.challenge!, progressType: 3) { result in
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
                        }
                    },
                          secondaryButton: .cancel()
                    )
                }
                .onAppear() {
                    self.challengeViewModel.getChallenge(id: challengeId) { result in
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
        }
    }
    
}
