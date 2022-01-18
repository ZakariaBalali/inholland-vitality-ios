//
//  TimelineCellPlaceholder.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/14/22.
//

import SwiftUI

struct TimelineCellPlaceholder: View {
    @State private var condition: Bool = false
    
    
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    
                    HStack{
                        
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 39))
                        
                            .clipShape(Circle())
                            .clipped()
                            .redacted(reason: .placeholder)
                            .opacity(condition ? 0.5 : 1.0)
                            .animation(Animation
                                        .easeInOut(duration: 1)
                                       .repeatForever(autoreverses: true), value: condition)
                            .onAppear { condition = true }
                        
                        VStack{
                            Text("Lorem Ipsum")
                                .font(Font.headline.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .redacted(reason: .placeholder)
                                .opacity(condition ? 0.5 : 1.0)
                                .animation(Animation
                                            .easeInOut(duration: 1)
                                           .repeatForever(autoreverses: true), value: condition)
                                .onAppear { condition = true }
                            Text(DateConverter.convertTime(of: "Lorem Ipsum"))
                                .font(Font.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color.gray)
                                .redacted(reason: .placeholder)
                                .opacity(condition ? 0.5 : 1.0)
                                .animation(Animation
                                            .easeInOut(duration: 1)
                                           .repeatForever(autoreverses: true), value: condition)
                                .onAppear { condition = true }
                            
                            
                        }
                        .padding(10)
                    }
                    .frame(maxWidth: .infinity,  alignment: .leading)
                    
                    Spacer()
                    Text(" ")
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                VStack{
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi mollis enim et quam efficitur luctus.")
                        .offset(y:-20)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .redacted(reason: .placeholder)
                        .opacity(condition ? 0.5 : 1.0)
                        .animation(Animation
                                    .easeInOut(duration: 1)
                                   .repeatForever(autoreverses: true), value: condition)
                        .onAppear { condition = true }
                    
                    Rectangle()
                        .fill(Color("commentGray"))
                        .frame(height: CGFloat(200))
                        .redacted(reason: .placeholder)
                        .opacity(condition ? 0.5 : 1.0)
                        .animation(Animation
                                    .easeInOut(duration: 1)
                                   .repeatForever(autoreverses: true), value: condition)
                        .onAppear { condition = true }
                    
                }
                HStack{
                    
                    Image("thumbsup_icon")
                        .resizable()
                        .frame(width: 15.0, height: 15.0)
                        .redacted(reason: .placeholder)
                        .padding(10)
                        .opacity(condition ? 0.5 : 1.0)
                        .animation(Animation
                                    .easeInOut(duration: 1)
                                   .repeatForever(autoreverses: true), value: condition)
                        .onAppear { condition = true }
                    Text(String(120))
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .redacted(reason: .placeholder)
                        .opacity(condition ? 0.5 : 1.0)
                        .animation(Animation
                                    .easeInOut(duration: 1)
                                   .repeatForever(autoreverses: true), value: condition)
                        .onAppear { condition = true }
                    
                    
                    Text(String(120) + " Reacties")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(10)
                        .redacted(reason: .placeholder)
                        .opacity(condition ? 0.5 : 1.0)
                        .animation(Animation
                                    .easeInOut(duration: 1)
                                   .repeatForever(autoreverses: true), value: condition)
                        .onAppear { condition = true }
                }
                
                
            }.overlay(VStack{Divider().offset(x: 0, y: 15)})
            HStack{
                
                
                HStack{
                    
                    HStack{
                        Image("thumbsup_icon_pink")
                            .padding(.horizontal, 2)
                            .redacted(reason: .placeholder)
                            .opacity(condition ? 0.5 : 1.0)
                            .animation(Animation
                                        .easeInOut(duration: 1)
                                       .repeatForever(autoreverses: true), value: condition)
                            .onAppear { condition = true }
                        Text("Vind ik leuk")
                            .redacted(reason: .placeholder)
                            .opacity(condition ? 0.5 : 1.0)
                            .animation(Animation
                                        .easeInOut(duration: 1)
                                        .repeatForever(autoreverses: true), value: condition)
                            .onAppear { condition = true }
                        
                    }.padding(.leading, 10)
                    
                    
                    HStack{
                        
                        Image("message_icon")
                            .padding(.horizontal, 2)
                            .redacted(reason: .placeholder)
                            .opacity(condition ? 0.5 : 1.0)
                            .animation(Animation
                                        .easeInOut(duration: 1)
                                       .repeatForever(autoreverses: true), value: condition)
                            .onAppear { condition = true }
                        Text("Reageren")
                            .redacted(reason: .placeholder)
                            .opacity(condition ? 0.5 : 1.0)
                            .animation(Animation
                                        .easeInOut(duration: 1)
                                       .repeatForever(autoreverses: true), value: condition)
                            .onAppear { condition = true }
                        
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                    
                }.frame(height: 50)
                
                
                
            }
            
        }
        
        
        
    }
}

