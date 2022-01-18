//
//  SearchCell.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/17/21.
//

import SwiftUI

struct SearchCell: View {
    @ObservedObject var userViewModel: UserViewModel
    let user: SearchResult
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: user.profilePicture ?? "empty")) { image in
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
                Text((user.jobTitle ??  "test") + ", " + (user.location ?? "test"))
                    .font(Font.footnote)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
    }
}


