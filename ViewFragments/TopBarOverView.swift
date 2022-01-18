//
//  TopBarOverView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/1/21.
//

import SwiftUI
import CachedAsyncImage
struct TopBarOverView: View {
    @ObservedObject var userViewModel: UserViewModel
    let user: UserResponse
    
    var body: some View {
        ZStack{
            Color("inhollandPink")
            HStack{
                VStack(spacing: 10){
                    Text(getGreeting() + ",") .font(Font.headline.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Text((user.firstName ?? " " ) + " " + (user.lastName ?? " "))
                        
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }.foregroundColor(Color.white)
                
                VStack{
                    AsyncImage(url: URL(string: user.profilePicture ?? "empty")) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color.white)
                        .font(.system(size: 60))                    }
                    .scaledToFill()
                    .frame(width: 60, height: 60, alignment: .center)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    Text(String(user.points ?? 0) + " " + String(localized:"overview_points"))
                        .font(Font.caption.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    NavigationLink(destination: ScoreboardView(userViewModel: userViewModel).overlay(alignment: .top, content: {
                        Color("inhollandPink")
                            .background(.regularMaterial)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 0)
                    }))
                    {
                        Text(String(localized: "view_scoreboard"))
                            .font(Font.subheadline.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }.foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }.padding(.leading, 20)
        }
    }
}
