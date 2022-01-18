//
//  EndpointsService.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/19/21.
//

import Foundation
import Combine

struct BaseURL {
    static let url = ""
}

protocol EndpointsService {
    
    func login(requestType: RequestType, endpoint: EndpointType, login: Login) -> AnyPublisher<LoginResponse, Error>?
    
    func refreshToken(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<LoginResponse, Error>?
    
    func fetchChallenges(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<ChallengeResponse, Error>?
    
    func fetchUser(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<UserResponse, Error>?
    
    func getChallenge(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<ChallengeResult, Error>?
    
    func fetchPost(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<TimelineResult, Error>?
    
    func deletePost(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<Bool, Error>?
    
    func fetchTimelinePosts(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<TimelineResponse, Error>?
    
    func fetchNotifications(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<NotificationResponse, Error>?
    
    func likeOrUnlikePost(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<Bool, Error>?
    
    func fetchTimelineComments(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<TimelineCommentResponse, Error>?
    
    func commentOnPost(requestType: RequestType, endpoint: EndpointType, comment: Comment) -> AnyPublisher<CommentOnPostResponse, Error>?
    
    func updateChallenge(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<String, Error>?
    
    func searchUser(requestType: RequestType, endpoint: EndpointType) ->AnyPublisher<SearchResponse, Error>?
    
    func getLikers(requestType: RequestType, endpoint: EndpointType) ->AnyPublisher<LikersResponse, Error>?
    
    func subscribeToChallenge(requestType: RequestType, endpoint: EndpointType) -> AnyPublisher<String, Error>?
}


enum EndpointType{
    case register
    case login
    case refreshToken(String)
    case searchUser(String, Int)
    case getUser(String)
    case getPost(String)
    case challenge
    case getChallenge(String)
    case getUsersChallenges(String)
    case timelinePosts(Int)
    case notifications(Int)
    case makeTimelinePost
    case getLikers(String, Int)
    case likeOrUnlike(String)
    case getCommentsTimeline(String, Int)
    case commentOnPost(String)
    case updateChallenge(String, Int)
    case scoreboard(Int)
    case followUser(String, String)
    case subscribeToChallenge(String)
    var urlExtension: String {
        switch self {
        case .register:
            return "user"
        case .login:
            return"login"
        case .refreshToken(let token):
            return"login/refresh?refreshToken=\(token)"
        case .searchUser(let name, let offset):
            return"users/\(name)?limit=15&offset=\(offset)"
        case .getUser(let id):
            return"user?userId=\(id)"
        case .getPost(let id):
            return"timelinepost/\(id)"
        case .challenge:
            return"challenge?limit=100&offset=0"
        case .getChallenge(let id):
            return"challenge/\(id)"
        case .timelinePosts(let offset):
            return"timelinepost?limit=10&offset=\(offset)"
        case .notifications(let offset):
            return"notification?limit=20&offset=\(offset)"
        case .makeTimelinePost:
            return"timelinepost"
        case .getLikers(let id, let offset):
            return"timelinepost/\(id)/likers?limit=15&offset=\(offset)"
        case .likeOrUnlike(let id):
            return"timelinepost/\(id)/like"
        case .getCommentsTimeline(let id, let offset):
            return "timelinepost/\(id)/comments?limit=10&offset=\(offset)"
        case .commentOnPost(let id):
            return "timelinepost/\(id)/comment"
        case .updateChallenge(let id, let progress):
            return "challenge/\(id)/progress?challengeProgress=\(progress)"
        case .scoreboard(let offset):
            return "user/scoreboard?limit=10&offset=\(offset)"
        case .followUser(let userId, let bool):
            return"user/follow?userId=\(userId)&following=\(bool)"
        case .getUsersChallenges(let id):
            return "challenge?limit=100&offset=0&userId=\(id)"
        case .subscribeToChallenge(let id):
            return"challenge/\(id)/subscribe"
        }
        
    }
}

enum RequestError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case genericError(Error)
}

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}




