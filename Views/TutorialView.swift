//
//  TutorialView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/10/22.
//

import SwiftUI

struct TutorialView: View {
    let userDefaults = UserDefaults.standard
    @State var tabSelection: Int = 1
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                NavigationLink(destination: LoginView()) {  Text(String(localized: "tutorial_skip"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(20)
                        .foregroundColor(Color.white)
                    .multilineTextAlignment(.center) }.simultaneousGesture(TapGesture().onEnded{
                        UserDefaults.standard.set(true, forKey: "firstLaunch")
                    })
                
                
                TabView(selection: $tabSelection) {
                    ZStack{
                        
                        Color("inhollandPink")
                        VStack{
                            
                            Text(String(localized: "tutorial_page1_title"))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                            
                            Image("vitalityIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                            Text(String(localized: "tutorial_page1_description"))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                            
                            Button(action:{
                                tabSelection = 2
                            }){
                                Text(String(localized: "tutorial_continue"))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: UIScreen.main.bounds.width - 60, minHeight:35)
                                    .foregroundColor(Color("inhollandPink"))
                                
                                    .background(Color.white)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        }
                    }.edgesIgnoringSafeArea(.all)
                        .tag(1)
                        .tabItem{
                            Text("skip")
                        }
                    ZStack{
                        Color("inhollandPink")
                        
                        VStack{
                            Text(String(localized: "challenge_type_mind"))
                                .fontWeight(.bold)
                                .foregroundColor(Color("challengeYellow"))
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 30))
                            
                            
                            Image("ontspanning_cutout")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                            Text(String(localized: "tutorial_mind_description"))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                            
                            Button(action:{
                                tabSelection = 3
                            }){
                                Text(String(localized: "tutorial_continue"))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: UIScreen.main.bounds.width - 60, minHeight:35)
                                    .foregroundColor(Color("inhollandPink"))
                                
                                    .background(Color.white)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        }
                    }.edgesIgnoringSafeArea(.all
                    )
                        .tag(2)
                    ZStack{
                        Color("inhollandPink")
                        
                        VStack{
                            Text(String(localized: "challenge_type_diet"))
                                .fontWeight(.bold)
                                .foregroundColor(Color("challengeYellow"))
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 30))
                            
                            
                            Image("voeding_cutout")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                            Text(String(localized: "tutorial_diet_description"))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                            
                            Button(action:{
                                tabSelection = 4
                            }){
                                Text(String(localized: "tutorial_continue"))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: UIScreen.main.bounds.width - 60, minHeight:35)
                                    .foregroundColor(Color("inhollandPink"))
                                
                                    .background(Color.white)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        }
                    }.edgesIgnoringSafeArea(.all
                    )
                        .tag(3)
                    ZStack{
                        Color("inhollandPink")
                        
                        VStack{
                            Text(String(localized: "challenge_type_exercise"))
                                .fontWeight(.bold)
                                .foregroundColor(Color("challengeYellow"))
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 30))
                            
                            
                            Image("bewegen_cutout")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                            Text(String(localized: "tutorial_exercise_description"))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                            
                            Button(action:{
                                tabSelection = 5
                            }){
                                Text(String(localized: "tutorial_continue"))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: UIScreen.main.bounds.width - 60, minHeight:35)
                                    .foregroundColor(Color("inhollandPink"))
                                    .background(Color.white)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                        }
                    }.edgesIgnoringSafeArea(.all
                    )
                        .tag(4)
                    ZStack{
                        Color("inhollandPink")
                        
                        VStack{
                            Text(String(localized: "tutorial_page5_title"))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20))
                                .padding(10)
                            Text(String(localized: "tutorial_page5_subtitle"))
                                .foregroundColor(Color.white)
                                .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center)
                                .padding(10)
                            HStack{
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.white)
                                Text(String(localized: "tutorial_page5_point1"))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .multilineTextAlignment(.center)
                            }.padding(10)
                            HStack{
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.white)
                                Text(String(localized: "tutorial_page5_point2"))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .multilineTextAlignment(.center)
                            }.padding(10)
                            HStack{
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.white)
                                Text(String(localized: "tutorial_page5_point3"))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .multilineTextAlignment(.center)
                            }.padding(10)
                            HStack{
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.white)
                                Text(String(localized: "tutorial_page5_point4"))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .multilineTextAlignment(.center)
                            }.padding(10)
                            HStack{
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.white)
                                Text(String(localized: "tutorial_page5_point5"))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity,  alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            }.padding(10)
                            Button(action:{
                                tabSelection = 5
                            }){
                                NavigationLink(destination: RegisterView()) {  Text(String(localized: "tutorial_signup"))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: UIScreen.main.bounds.width - 60, minHeight:35)
                                        .foregroundColor(Color("inhollandPink"))
                                    .background(Color.white) }.simultaneousGesture(TapGesture().onEnded{
                                        UserDefaults.standard.set(true, forKey: "firstLaunch")
                                    })
                                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            .padding(.top, 20)
                            
                            NavigationLink(destination: LoginView()) {  Text(String(localized: "tutorial_login"))
                                    .foregroundColor(Color.white)
                                    .frame(width: UIScreen.main.bounds.width - 60,  alignment: .center)
                                .multilineTextAlignment(.center) }.simultaneousGesture(TapGesture().onEnded{
                                    UserDefaults.standard.set(true, forKey: "firstLaunch")
                                })
                            
                            
                            
                        }
                    }.edgesIgnoringSafeArea(.all
                    )
                        .tag(5)
                }.tabViewStyle(PageTabViewStyle())
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                
            }.frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color("inhollandPink"))
        }
    }
}

