//
//  ChallengeView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import SwiftUI
import CachedAsyncImage
import SwiftUIPullToRefresh
struct TimelineView: View {
    @ObservedObject var timelineViewModel: TimelineViewModel
    @ObservedObject var userViewModel: UserViewModel
    @Binding var selection: Int
    var body: some View {
        ZStack(alignment: .top){
            VStack(spacing:0){
                
                HStack{
                    
                    AsyncImage(url: URL(string: userViewModel.user?.profilePicture ?? "empty")) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20))
                    }
                    .clipShape(Circle())
                    .scaledToFill()
                    .clipped()
                    .frame(width: 39, height: 39, alignment: .center)
                    .padding(5)
                    
                    NavigationLink(destination: SearchView(userViewModel: userViewModel).overlay(alignment: .top, content: {
                        Color("inhollandPink")
                            .background(.regularMaterial)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
                    })){
                        Text(String(localized: "timeline_search_placeholder")).font(.subheadline)
                            .padding(.leading, 10)
                            .foregroundColor(Color.gray)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.3, minHeight: 40, alignment: .leading)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))

                }.frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                    .background(Color("inhollandPink"))
                    .offset(y: -3)
                
                
                
            }.navigationBarHidden(true)
        }
        VStack(spacing: 0){
            if timelineViewModel.timelinePosts.isEmpty {
                RefreshableScrollView(onRefresh: { done in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            timelineViewModel.timelinePosts.removeAll()
                            timelineViewModel.offset = 0
                            timelineViewModel.fetchTimelinePosts { result in
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
                          done()
                        }
                      }) {
                        LazyVStack{
                            ForEach(1...5, id: \.self) { i in

                            TimelineCellPlaceholder()
                                .frame(width: UIScreen.main.bounds.width - 30,  alignment: .center)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                .shadow(color: Color.black, radius: 1, x: 0, y: 0)
                                .padding(.bottom, 8)
                                .foregroundColor(Color.black)
                        }
                        
                        } .frame(width: UIScreen.main.bounds.width,  alignment: .center)
                        .padding(.top, 10)
                }
                    .onAppear(){
                        timelineViewModel.fetchTimelinePosts { result in
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
                RefreshableScrollView(onRefresh: { done in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            timelineViewModel.timelinePosts.removeAll()
                            timelineViewModel.offset = 0
                            timelineViewModel.fetchTimelinePosts { result in
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
                          done()
                        }
                      }) {
                    LazyVStack {
                   
                                        
                                   
                        ForEach(timelineViewModel.timelinePosts) { timelinePost in
                           
                            
                            TimelineCell(timelineViewModel: timelineViewModel, userViewModel: userViewModel, timelinePost: timelinePost)
                                .frame(width: UIScreen.main.bounds.width - 30,  alignment: .center)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                .shadow(color: Color.black, radius: 1, x: 0, y: 0)
                                .padding(.bottom, 8)
                                .foregroundColor(Color.black)
                            
                            
                        }
                        
                        Text("")
                            .onAppear {
                                DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                                    timelineViewModel.fetchTimelinePosts { result in
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

