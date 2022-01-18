//
//  ChallengeCellPlaceholder.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/14/22.
//

import SwiftUI

struct ChallengeCellPlaceholder: View {
    @State private var condition: Bool = false

    var body: some View {
        VStack{
            VStack{
                
                    Text("Geest")
                        .font(Font.headline.weight(.bold))
                        .padding(10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .redacted(reason: .placeholder)
                        .opacity(condition ? 0.5 : 1.0)
                        .animation(Animation
                                    .easeInOut(duration: 1)
                                   .repeatForever(autoreverses: true), value: condition)
                        .onAppear { condition = true }
                
                
            
                    
            } .frame(width: 174)
                .background(
                    Image("challenge_placeholder")
                        .resizable()
                                .scaledToFill()
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.1), .black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                                .clipped())
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                .redacted(reason: .placeholder)
                .opacity(condition ? 0.5 : 1.0)
                .animation(Animation
                            .easeInOut(duration: 1)
                           .repeatForever(autoreverses: true), value: condition)
                .onAppear { condition = true }

            
            Text("Lorem ipsum Lorem Ipsum")
                .redacted(reason: .placeholder)
                .opacity(condition ? 0.5 : 1.0)
                .animation(Animation
                            .easeInOut(duration: 1)
                           .repeatForever(autoreverses: true), value: condition)
                .onAppear { condition = true }
           
                Text("BEKIJK ACTIVITEIT")
                .opacity(condition ? 0.5 : 1.0)
            .foregroundColor(Color("commentGray"))
            .padding(8)
            .background(Color("commentGray"))
            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
            .animation(Animation
                        .easeInOut(duration: 1)
                       .repeatForever(autoreverses: true), value: condition)
            .onAppear { condition = true }
        }
    }
}

