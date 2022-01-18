//
//  NotificationCell.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 1/1/22.
//

import SwiftUI

struct NotificationCell: View {
    let notification: NotificationResult
    @State var isFollowing: Bool = false
    var body: some View {
        HStack{
        if(notification.notificationType == 4){
            Image("challenge_notification")
                .resizable()
                .clipShape(Circle())
                .scaledToFill()
                .clipped()
                .frame(width: 39, height: 39, alignment: .center)
        }else{
      
            AsyncImage(url: URL(string: notification.profilePictureSender ?? "empty")) { image in
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
        }
            VStack{
                HStack{
                    if(notification.notificationType == 1){
                        Text(notification.fullNameSender)
                            .fontWeight(.bold) +
                        Text(" " + String(localized: "notification_like"))
                    }
                    if(notification.notificationType == 2){
                        Text(notification.fullNameSender)
                            .fontWeight(.bold) +
                        Text(" " + String(localized: "notification_comment"))

                    }
                    if(notification.notificationType == 4){
                        VStack{
                            Text(" " + String(localized: "notification_activity"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(" " + String(localized: "notification_click"))
                                .foregroundColor(Color("inhollandPink"))
                                .font(Font.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)

                        }
                        
                    }
                    if(notification.notificationType == 3){
                        Text(notification.fullNameSender)
                            .fontWeight(.bold) +
                        Text(" " + String(localized: "notification_follow"))
                        Spacer()
                     
                    }
                }                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                if(notification.notificationType != 4){
                Text(DateConverter.convertTime(of: notification.timeOfNotification))
                    .font(Font.footnote)
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
            .onAppear {
                isFollowing = notification.isFollowing ?? false
            }
    }
}
