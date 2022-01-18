//
//  PostMessageView.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/6/21.
//

import SwiftUI


struct PostMessageView: View {
    @State var text: String = String(localized: "comment_message")
    @State var isRequestErrorViewPresented: Bool = false
    @State var isPosting: Bool = false
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @ObservedObject var timelineViewModel: TimelineViewModel
    @ObservedObject var userViewModel: UserViewModel
    @Binding var selection: Int
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        if self.isPosting {
            ProgressView("Posting...")
        } else {
            ZStack(alignment: .top){
                VStack(spacing:0){
                    
                    HStack{
                        Button(action:{
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .padding(.leading, 10)
                                .foregroundColor(Color.white)

                            HStack{
                                Text(String(localized: "back_button"))
                                    .frame(height: 40)
                                    .foregroundColor(Color.white)
                                
                                
                            }.padding(10)
                            
                            
                        }
                    }.frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                        .background(Color("inhollandPink"))
                        .offset(y: -3)
                    
                    
                }.navigationBarHidden(true)
            }
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
                        if((text == String(localized: "comment_message")) || text.count < 4 ){
                            
                            Text("POST")
                                .frame(maxWidth: 100, minHeight:35)
                                .background(Color.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                            
                                .foregroundColor(Color.white)
                        }
                        else{
                            
                            Button(action: {
                                TimelineViewModel.timelineVM.makeTimelinePost(uiImage: self.image, text: text, endpoint: .makeTimelinePost) { result in
                                    switch result {
                                    case .failure:
                                        self.isRequestErrorViewPresented = true
                                        self.isPosting = false
                                    case .success:
                                        self.presentationMode.wrappedValue.dismiss()
                                        self.isPosting = false
                                        self.image = UIImage()
                                        self.text = String(localized: "comment_message")
                                        self.timelineViewModel.timelinePosts.removeAll()
                                        self.timelineViewModel.offset = 0
                                        self.selection = 5
                                        self.selection = 2
                                    }
                                }
                            }
                            ){
                                Text("POST")
                            }.frame(maxWidth: 100, minHeight:35)
                                .background(Color("inhollandPink"))
                                .foregroundColor(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
                        }
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                }.padding(.leading, 10)
                TextEditor(text: $text)
                    .accentColor(.black)
                    .padding(.leading, 10)
                    .foregroundColor(text == String(localized: "comment_message") ? .gray  : .black)
                    .onTapGesture(){
                        text = ""
                    }
                Spacer()
            }.padding(.top, 20)
                .alert(isPresented: $isRequestErrorViewPresented) {
                    Alert(title: Text(String(localized: "error_message")), message: Text(String(localized: "post_message_error")), dismissButton: .default(Text(String(localized: "login_try_again"))))
                }
        }
        
        VStack {
            Button(action:{
                self.image = UIImage()
            }){
                ZStack{
                    if(self.image.size.width != 0){
                        Image(uiImage: self.image)
                         
                            .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                                .clipped()
                                .padding(.bottom)

                        
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                                .background(
                                  Color.white.mask(Circle())
                                )
                            .font(.system(size: 25))
                            .padding(10)
                         
                    }
                }
            }
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                        .foregroundColor(Color("inhollandPink"))
                    Text(String(localized: "post_message_image"))
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.white)
                .foregroundColor(.black)
            }
        }
        .fullScreenCover(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
    
}

