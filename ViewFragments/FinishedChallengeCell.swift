//
//  FinishedChallengeCell.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/30/21.
//

import SwiftUI

struct FinishedChallengeCell: View {
    @ObservedObject var challengeViewModel: ChallengeViewModel
    let challenge: ChallengeResult
    var body: some View {
        VStack{
            VStack{
                if challenge.challengeType == 1{
                    Text(String(localized: "challenge_type_exercise"))
                        .font(Font.headline.weight(.bold))
                        .padding(10)
                        .foregroundColor(Color("challengeYellow"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    
                }
                else if challenge.challengeType == 2{
                    Text(String(localized: "challenge_type_diet"))
                        .font(Font.headline.weight(.bold))
                        .padding(10)
                        .foregroundColor(Color("challengeYellow"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                }
                else if challenge.challengeType == 3{
                    Text(String(localized: "challenge_type_mind"))
                        .font(Font.headline.weight(.bold))
                        .padding(10)
                        .foregroundColor(Color("challengeYellow"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    
                }

            } .frame(width: 174, height: CGFloat(90))
                .background(   AsyncImage(url: URL(string: challenge.imageLink ?? "empty")) { image in
                    image.resizable()
                } placeholder: {
                    Image("challenge_placeholder")
                        .resizable()
                        .scaledToFill()
                        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
                                .scaledToFill()
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                                .clipped())
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
            
            Text(challenge.title)
                .font(.system(size: 13))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            //text behouden voor consistente size
            Text(" ")
            
                .foregroundColor(.white)
                .padding(8)
                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
        }.frame(maxWidth: 174)
    }
}

