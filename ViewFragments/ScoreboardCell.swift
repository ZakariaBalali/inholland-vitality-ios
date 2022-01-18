//
//  ScoreboardCell.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/1/22.
//

import SwiftUI

struct ScoreboardCell: View {
    let scoreboard: PointsResult
    let position: Int
    var body: some View {
        HStack{
            if((position + 1) == 1){
                Text(String(position + 1))
                    .foregroundColor(Color("inhollandPink"))
                    .fontWeight(.bold)
            }
            if((position + 1) == 2){
                Text(String(position + 1))
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
            }
            if((position + 1) == 3){
                Text(String(position + 1))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
            }
            if((position + 1) > 3){
                Text(String(position + 1))
                    .foregroundColor(Color.black)
                
            }
            
            AsyncImage(url: URL(string: scoreboard.profilePicture ?? "empty")) { image in
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
            
            
            HStack{
                if((position + 1) == 1){
                    Text(scoreboard.fullName ?? " ")
                        .foregroundColor(Color("inhollandPink"))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text(String(scoreboard.points))
                        .foregroundColor(Color("inhollandPink"))
                        .fontWeight(.bold)
                }
                if((position + 1) == 2){
                    Text(scoreboard.fullName ?? " ")
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text(String(scoreboard.points))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                }
                if((position + 1) == 3){
                    Text(scoreboard.fullName ?? " ")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    Text(String(scoreboard.points))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                }
                if((position + 1) > 3){
                    Text(scoreboard.fullName ?? " ")
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text(String(scoreboard.points))
                        .foregroundColor(Color.black)
                    
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
    }
}

