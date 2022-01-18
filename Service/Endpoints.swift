//
//  Endpoints.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/19/21.
//

import Foundation
import Combine
import Alamofire
class VitalityAPI: EndpointsService {
    
    
    
    
    static let shared = VitalityAPI()
    private var cancellable = Set<AnyCancellable>()
    private init() {}
    
    func execute<ResponseType: Decodable>(request: URLRequest) -> AnyPublisher<ResponseType, Error>{
        URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: ResponseType.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login(requestType: RequestType, endpoint: EndpointType, login: Login) -> AnyPublisher<LoginResponse, Error>?{
        
        let stringURL = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: stringURL) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.httpMethod = requestType.rawValue
        guard let body = try? JSONEncoder().encode(login) else { return nil }
        requestURL.httpBody = body
        
        return execute(request: requestURL)
    }
    
    func refreshToken(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<LoginResponse, Error>?{
        
        let stringURL = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: stringURL) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.httpMethod = requestType.rawValue        
        return execute(request: requestURL)
    }
    
    
    func fetchChallenges(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<ChallengeResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func fetchUser(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<UserResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func fetchPost(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<TimelineResult, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func deletePost(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<Bool, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func getChallenge(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<ChallengeResult, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func searchUser(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<SearchResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func getLikers(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<LikersResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func getScoreboard(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<PointsResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func fetchTimelinePosts(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<TimelineResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func subscribeToChallenge(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<String, Error>? {
        let stringURL = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: stringURL) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
        
    }
    
    func fetchNotifications(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<NotificationResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func likeOrUnlikePost(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<Bool, Error>? {
        let stringURL = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: stringURL) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func fetchTimelineComments(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<TimelineCommentResponse, Error>? {
        let urlString = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: urlString) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
    
    func commentOnPost(requestType: RequestType, endpoint: EndpointType, comment: Comment) -> AnyPublisher<CommentOnPostResponse, Error>? {
        let stringURL = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: stringURL) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        guard let body = try? JSONEncoder().encode(comment) else { return nil }
        requestURL.httpBody = body
        return execute(request: requestURL)
    }
    
    func updateChallenge(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<String, Error>? {
        let stringURL = BaseURL.url + endpoint.urlExtension
        guard let url = URL(string: stringURL) else {
            return nil
        }
        var requestURL = URLRequest(url: url)
        requestURL.setValue(LoginViewModel.loginVM.accessToken, forHTTPHeaderField: "Authorization")
        requestURL.httpMethod = requestType.rawValue
        return execute(request: requestURL)
    }
}
