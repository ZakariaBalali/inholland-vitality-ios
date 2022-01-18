//
//  HomeView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/19/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var loginViewModel = LoginViewModel.loginVM
    @StateObject var challengeViewModel = ChallengeViewModel.challengeVM
    @StateObject var userViewModel = UserViewModel.userVM
    @StateObject var timelineViewModel = TimelineViewModel()
    @State var tabSelection: Int = 0
    @State var isPresenting = false
    @State private var oldSelectedItem = 1
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor( Color.white)]
        
    }
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            NavigationView {
                if userViewModel.user != nil{
                    OverView(challengeViewModel: challengeViewModel, userViewModel: userViewModel)
                        .onAppear() {
                            
                            self.challengeViewModel.fetchChallenges {_ in}
                            
                        }
                }
                else{
                    OverViewPlaceholder()
                            .onAppear() {
                                self.userViewModel.fetchUser { result in
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
                
            }.navigationViewStyle(StackNavigationViewStyle())
                .accentColor(Color.white)
                .tabItem {
                    Image(systemName: "house.fill").foregroundColor(Color("inhollandPink"))
                    Text(String(localized: "tab_home"))
                }.tag(1)
            NavigationView {
                
                VStack{
                    
                    
                    TimelineView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, selection: $tabSelection)
                        .navigationBarTitleDisplayMode(.inline)
                    
                }
                
            }.navigationViewStyle(StackNavigationViewStyle())
            
                .accentColor(Color.white)
                .tabItem {
                    Image(systemName: "rectangle.grid.2x2.fill")
                    Text(String(localized: "tab_timeline"))
                }.tag(2)
            NavigationView {
                VStack{
                    Rectangle()
                        .frame(height: 0)
                        .background(Color("inhollandPink"))
                    
                    
                    
                }.tag(3)
                
                
            }.navigationViewStyle(StackNavigationViewStyle())
                .accentColor(Color.white)
            
                .tabItem {
                    Image(systemName: "plus.square.fill")
                    Text(String(localized: "tab_post"))
                }.tag(3)
            NavigationView {
                VStack{
                    Rectangle()
                        .frame(height: 0)
                        .background(Color("inhollandPink"))
                    NotificationView(userViewModel: userViewModel, timelineViewModel: timelineViewModel)
                        .navigationTitle(String(localized: "tab_notifications"))
                        .foregroundColor(Color.white)
                }
                
                
            }.navigationViewStyle(StackNavigationViewStyle())
                .accentColor(Color.white)
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text(String(localized: "tab_notifications"))
                }.tag(4)
            NavigationView {
                
                ProfileView(challengeViewModel: challengeViewModel, userViewModel: userViewModel)
                    .navigationBarItems(trailing: Button(action: {
                        self.doOnceLoggedout()
                    }, label: {VStack{ Image(systemName: "arrow.right.square"); Text(String(localized: "log_out")).font(.caption)}}))
                   
                
                
                
            }.navigationViewStyle(StackNavigationViewStyle())
                .accentColor(Color.white)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text(String(localized: "tab_profile"))
                }.tag(5)
            
        }.onChange(of: tabSelection) {    // SwiftUI 2.0 track changes
            if 3 == tabSelection {
                self.isPresenting = true
            } else {
                self.oldSelectedItem = $0
            }
        }
        .fullScreenCover(isPresented: $isPresenting, onDismiss: {
            self.tabSelection = self.oldSelectedItem
            self.tabSelection = self.oldSelectedItem
        }) {
            PostMessageView(timelineViewModel: timelineViewModel, userViewModel: userViewModel, selection: $tabSelection)
                .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(Color("inhollandPink"))
        
    }
    
    func doOnceLoggedout() {
        self.loginViewModel.logout()
        self.challengeViewModel.challenges.removeAll()
        self.challengeViewModel.challengesActive.removeAll()
        self.timelineViewModel.timelinePosts.removeAll()
        self.userViewModel.notifications.removeAll()
        self.userViewModel.user = nil
        
    }
}
