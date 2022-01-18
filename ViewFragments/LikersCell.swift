//
//  LikersCell.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/1/22.
//

import SwiftUI

struct LikersCell: View {
    let user: LikersResult
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: user.imageUrl ?? "empty")) { image in
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
            
            VStack{
                Text(user.fullName ?? " ")
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text((user.jobTitle ??  " ") + ", " + (user.location ?? " "))
                    .font(Font.footnote)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
    }
}


