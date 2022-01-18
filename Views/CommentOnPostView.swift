//
//  CommentOnPostView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/8/21.
//

import SwiftUI
struct CommentOnPostView: View {
    @State var text: String = ""
    @State var isPosting: Bool = false
    @State var isRequestErrorViewPresented: Bool = false
    @ObservedObject var timelineViewModel: TimelineViewModel
    @ObservedObject var userViewModel: UserViewModel
    let timelinePost: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        if isPosting {
            ProgressView()
        } else {
            
            VStack{
                HStack{
                    AsyncImage(url: URL(string: userViewModel.user?.profilePicture ?? "empty")) { image in
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
                    Text((userViewModel.user?.firstName ?? " ") + " " + (userViewModel.user?.lastName ?? " "))
                    VStack{
                        if(text.count < 1){
                            
                            Text("POST")
                                .frame(maxWidth: 100, minHeight:35)
                                .background(Color.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                                .foregroundColor(Color.white)
                        }
                        else{
                            Button(action: {
                                isPosting = true
                                timelineViewModel.commentOnPost(for: Comment(text: text), timelinePost: timelinePost) { result in
                                    switch result {
                                    case .success(_):
                                        
                                        self.presentationMode.wrappedValue.dismiss()
                                    case.failure(let error):
                                        self.isRequestErrorViewPresented = true
                                        switch error {
                                        case .urlError(let urlError):
                                            print("URL Error: \(String(describing: urlError))")
                                        case .decodingError(let decodingError):
                                            print("Decoding Error: \(String(describing: decodingError))")
                                        case .genericError(let error):
                                            print("Error: \(String(describing: error))")
                                        }
                                    }
                                    self.isPosting = false
                                }
                            }){
                                Text("POST")
                            }.frame(maxWidth: 100, minHeight:35)
                                .background(Color("inhollandPink"))
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                    
                }.padding(.leading, 10)
                TextField(String(localized: "comment_message"), text: $text)
                    .padding(.leading, 10)
                    .accentColor(Color.black)
                Spacer()
            }.padding(.top, 20)
            
        }
    }
}
