//
//  ChallengeViewModel.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import Combine
import SwiftUI
import Alamofire

class TimelineViewModel: ObservableObject {
    @Published var isPosting: Bool = false
    static let timelineVM = TimelineViewModel()
    @Published var timelinePosts: [TimelineResult] = []
    @Published var timelineComments: [TimelineCommentResult] = []
    var cancellationToken = Set<AnyCancellable>()
    @Published var offset: Int = 0
    @Published var offsetComments: Int = 0
    @Published var timelinepost: TimelineResult? = nil
    @Published var hasPosted: Bool = true
    
}

extension TimelineViewModel {
    
    func fetchTimelinePosts(completion: @escaping (Result<TimelineResponse, RequestError>) -> Void) {
        VitalityAPI.shared.fetchTimelinePosts(requestType: .get, endpoint: .timelinePosts(self.offset))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            }, receiveValue: { [self] (response) in
                if(self.timelinePosts.isEmpty){
                    self.timelinePosts = response.results
                }else{
                    if(timelinePosts.count > 9){
                    self.timelinePosts.append(contentsOf: response.results)
                    }
                }
                self.offset += 10
            })
            .store(in: &cancellationToken)
        
    }
    
    func makeTimelinePost(uiImage: UIImage, text: String, endpoint: EndpointType, completion: @escaping (Result<String, Error>) -> Void) {
        
        self.isPosting = true
        let stringURL = BaseURL.url + endpoint.urlExtension
        let parameters = ["Text": text]
        
        let headers: HTTPHeaders = [
            .authorization(LoginViewModel.loginVM.accessToken!),
            .accept("application/json")
            
        ]
        if(uiImage.size.width != 0){
            let imageData = uiImage.jpegData(compressionQuality: 0.5)!
            AF.upload(multipartFormData: { (multiFormData) in
                for (key, value) in parameters {
                    multiFormData.append(Data(value.utf8), withName: key)
                }
                
                multiFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }, to: stringURL, method: .post, headers: headers).validate(statusCode: 200..<300)
                .responseString { response in
                    switch response.result {
                    case .success(let result):
                        completion(.success(result))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }else{
            AF.upload(multipartFormData: { (multiFormData) in
                for (key, value) in parameters {
                    multiFormData.append(Data(value.utf8), withName: key)
                }
                
            }, to: stringURL, method: .post, headers: headers).validate(statusCode: 200..<300)
                .responseString { response in
                    switch response.result {
                    case .success(let result):
                        completion(.success(result))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    }
    
    
    func likePost(timelinePost: TimelineResult,completion: @escaping (Result<Bool, RequestError>) -> Void){
        timelinePost.iLikedPost.toggle()
        VitalityAPI.shared.likeOrUnlikePost(requestType: .put, endpoint: .likeOrUnlike(timelinePost.id))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        completion(.failure(.decodingError(decodingError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            }, receiveValue: { result in
                
            })
            .store(in: &cancellationToken)
    }
    
    func unlikePost(timelinePost: TimelineResult,completion: @escaping (Result<Bool, RequestError>) -> Void){
        timelinePost.iLikedPost.toggle()
        VitalityAPI.shared.likeOrUnlikePost(requestType: .delete, endpoint: .likeOrUnlike(timelinePost.id))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        completion(.failure(.decodingError(decodingError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            }, receiveValue: { result in
            })
            .store(in: &cancellationToken)
    }
    
    func fetchTimelineComments(timelinePost: String, completion: @escaping (Result<TimelineResponse, RequestError>) -> Void) {
        VitalityAPI.shared.fetchTimelineComments(requestType: .get, endpoint: .getCommentsTimeline(timelinePost, offsetComments))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            }, receiveValue: { (response) in
                
                if(self.timelineComments.isEmpty){
                    self.timelineComments = response.results
                }else{
                    self.timelineComments.append(contentsOf: response.results)
                }
                self.offsetComments += 10
            })
            .store(in: &cancellationToken)
        
    }
    
    func getPost(id: String, completion: @escaping (Result<TimelineResult, RequestError>) -> Void) {
        VitalityAPI.shared.fetchPost(requestType: .get, endpoint: .getPost(id))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        completion(.failure(.decodingError(decodingError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            }, receiveValue: { (response) in
                
                
                self.timelinepost = response
                completion(.success(response))
                
            })
            .store(in: &cancellationToken)
        
    }
    
    func deletePost(id: String, completion: @escaping (Result<Bool, RequestError>) -> Void) {
        VitalityAPI.shared.deletePost(requestType: .delete, endpoint: .getPost(id))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    self.timelinePosts.removeAll(where: { $0.id == id} )
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        completion(.failure(.decodingError(decodingError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            }, receiveValue: { (response) in
                
                
                completion(.success(response))
                
            })
            .store(in: &cancellationToken)
        
    }
    func commentOnPost(for comment: Comment, timelinePost: String, completion: @escaping (Result<CommentOnPostResponse, RequestError>) -> Void) {
        VitalityAPI.shared.commentOnPost(requestType: .post, endpoint: .commentOnPost(timelinePost), comment: comment)?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    self.timelinePosts.first(where: {$0.id == timelinePost})?.countOfComments += 1

                case.failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        completion(.failure(.decodingError(decodingError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
                }
            } , receiveValue: { result in
                completion(.success(result))
            })
            .store(in: &cancellationToken)
    }
    
}



