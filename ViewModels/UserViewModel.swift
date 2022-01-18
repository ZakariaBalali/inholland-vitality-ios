//
//  UserViewModel.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 12/1/21.
//

import Foundation
import Combine
import SwiftUI
import KeychainAccess
import Alamofire
class UserViewModel: ObservableObject {
    static let userVM = UserViewModel()
    @Published var user: UserResponse? = nil
    @Published var search: [SearchResult] = []
    @Published var likers: [LikersResult] = []
    @Published var scoreboard: [PointsResult] = []
    @Published var getUser: UserResponse? = nil
    @Published var notifications: [NotificationResult] = []
    @Published var isFollowing: Bool = false
    @Published var isLoaded: Bool = false
    var cancellationToken = Set<AnyCancellable>()
    @Published var offset: Int = 0
    @Published var offsetSearch: Int = 0
    @Published var offsetScorebord: Int = 0
    @Published var offsetLikers: Int = 0
    @Published var hasSearched: Bool = false
    private let keychain = Keychain()
    private var userID = "userID"
    
    var userIdForProfile: String? {
        get {
            try? keychain.get(userID)
        }
        set(newValue) {
            guard let userId = newValue else {
                try? keychain.remove(userID)
                return
            }
            try? keychain.set("\(userId)", key: userID)
        }
    }
}

extension UserViewModel{
    
    func fetchUser(completion: @escaping (Result<UserResponse, RequestError>) -> Void) {
        VitalityAPI.shared.fetchUser(requestType: .get, endpoint: .register)?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure:
                    LoginViewModel.loginVM.refreshAccessToken(token: LoginViewModel.loginVM.refreshToken ?? " ") { result in
                        switch result {
                        case .success(_):
                            self.fetchUser { result in
                                switch result {
                                case .success(_):
                                    break;
                                case .failure(let error):
                                    switch error {
                                    case .urlError(let urlError):
                                        print("URL Error user: \(String(describing: urlError))")
                                    case .decodingError(let decodingError):
                                        print("Decoding Error user: \(String(describing: decodingError))")
                                    case .genericError(let error):
                                        print("Error: \(String(describing: error))")
                                    }
                                }
                            }
                        case.failure:
                            self.fetchUser { result in
                                switch result {
                                case .success(_):
                                    break;
                                case .failure(let error):
                                    switch error {
                                    case .urlError(let urlError):
                                        print("URL Error user: \(String(describing: urlError))")
                                    case .decodingError(let decodingError):
                                        print("Decoding Error user: \(String(describing: decodingError))")
                                    case .genericError(let error):
                                        print("Error: \(String(describing: error))")
                                    }
                                }
                            }
                        }
                    }
                }
            }, receiveValue: { (response) in
                
                
                self.user = response
                self.userIdForProfile = response.id
                completion(.success(response))
                
            })
            .store(in: &cancellationToken)
        
    }
    
    func fetchNotifications(completion: @escaping (Result<NotificationResponse, RequestError>) -> Void) {
        
        VitalityAPI.shared.fetchNotifications(requestType: .get, endpoint: .notifications(self.offset))?
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
                if(self.notifications.isEmpty){
                    self.notifications = response.results
                }else{
                    self.notifications.append(contentsOf: response.results)
                }
                self.offset += 20
            })
            .store(in: &cancellationToken)
        
    }
    
    func searchUser(query: String, completion: @escaping (Result<SearchResponse, RequestError>) -> Void) {
        VitalityAPI.shared.searchUser(requestType: .get, endpoint: .searchUser(query, offsetSearch))?
            .sink(receiveCompletion: { result in
                
                switch result {
                case .finished:
                    self.hasSearched = true
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
                if(self.search.isEmpty){
                    self.search = response.results
                }else{
                    self.search.append(contentsOf: response.results)
                }
                self.offsetSearch += 15
                
                completion(.success(response))
            })
            .store(in: &cancellationToken)
        
    }
    
    func getLikers(id: String, completion: @escaping (Result<LikersResponse, RequestError>) -> Void) {
        VitalityAPI.shared.getLikers(requestType: .get, endpoint: .getLikers(id, offsetLikers))?
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
                if(self.likers.isEmpty){
                    self.likers = response.results
                }else{
                    self.likers.append(contentsOf: response.results)
                }
                self.offsetLikers += 15
                
                completion(.success(response))            })
            .store(in: &cancellationToken)
        
    }
    
    func getScoreboard(completion: @escaping (Result<PointsResponse, RequestError>) -> Void) {
        VitalityAPI.shared.getScoreboard(requestType: .get, endpoint: .scoreboard(self.offsetScorebord))?
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
                
                if(self.scoreboard.isEmpty){
                    self.scoreboard = response.results
                }
                else{
                    self.scoreboard.append(contentsOf: response.results)
                }
                completion(.success(response))
                self.offsetScorebord += 10
                
            })
            .store(in: &cancellationToken)
        
    }
    
    func getUser(id: String, completion: @escaping (Result<UserResponse, RequestError>) -> Void) {
        VitalityAPI.shared.fetchUser(requestType: .get, endpoint: .getUser(id))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    self.isLoaded = true
                    ChallengeViewModel.challengeVM.fetchUsersChallenges(id: id) { result in
                        switch result {
                        case .success(_):
                            break
                        case .failure(let error):
                            switch error {
                            case .urlError(let urlError):
                                print("URL Error: \(String(describing: urlError))")
                            case .decodingError(let decodingError):
                                print("Decoding Error: \(String(describing: decodingError))")
                            case .genericError(let error):
                                print("Error: \(String(describing: error))")
                            }
                        }
                    }
                case .failure(_):
                    self.getUser(id: id) { result in
                        switch result {
                        case .success(_):
                            break
                        case .failure(let error):
                            switch error {
                            case .urlError(let urlError):
                                print("URL Error: \(String(describing: urlError))")
                            case .decodingError(let decodingError):
                                print("Decoding Error: \(String(describing: decodingError))")
                            case .genericError(let error):
                                print("Error: \(String(describing: error))")
                            }
                        }
                    }                }
            }, receiveValue: { (response) in
                
                
                self.getUser = response
                self.isFollowing = response.following ?? false
                print(self.getUser?.firstName ?? "empty")
                completion(.success(response))
                
            })
            .store(in: &cancellationToken)
        
    }
    
    func changeFollowStatus(endpoint: EndpointType,  completion: @escaping (Result<Any, Error>) -> Void) {
        let stringURL = BaseURL.url + endpoint.urlExtension
        
        let headers: HTTPHeaders = [
            .authorization(LoginViewModel.loginVM.accessToken ?? " "),
            .accept("application/json")
            
        ]
        
        AF.request(stringURL, method: .post, headers: headers).validate(statusCode: 200..<300)
            .responseJSON { response in
                switch(response.result) {
                case .success(let response):
                    self.isFollowing.toggle()
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
