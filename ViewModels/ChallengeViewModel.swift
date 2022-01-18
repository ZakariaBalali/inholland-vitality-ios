//
//  ChallengeViewModel.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import Combine
import SwiftUI

class ChallengeViewModel: ObservableObject {
    static let challengeVM = ChallengeViewModel()
    @Published var allChallenges: [ChallengeResult] = []
    @Published var challenges: [ChallengeResult] = []
    @Published var challengesActive: [ChallengeResult] = []
    @Published var challengesFinished: [ChallengeResult] = []
    @Published var usersAllChallenges: [ChallengeResult] = []
    @Published var usersChallenges: [ChallengeResult] = []
    @Published var usersChallengesActive: [ChallengeResult] = []
    @Published var usersChallengesFinished: [ChallengeResult] = []
    @Published var challenge: ChallengeResult? = nil
    
    @Published var images = [String : Data]()
    var cancellationToken = Set<AnyCancellable>()
}

extension ChallengeViewModel {
    
    func fetchChallenges(completion: @escaping (Result<ChallengeResponse, RequestError>) -> Void) {
        VitalityAPI.shared.fetchChallenges(requestType: .get, endpoint: .challenge)?
            .sink(receiveCompletion: { result in
                
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case _ as DecodingError:
                        if(self.allChallenges.isEmpty){
                            self.fetchChallenges {_ in}
                        }
                            
                    default:
                        completion(.failure(.genericError(error)))
                    }
                    
                }
            }, receiveValue: { (response) in
                self.challenges = response.results.filter {$0.challengeProgress == 0 || $0.challengeProgress == 3}
                self.challengesActive = response.results.filter {$0.challengeProgress == 1}
                self.challengesFinished = response.results.filter {$0.challengeProgress == 2}
                
                self.allChallenges = response.results
                completion(.success(response))
            })
            .store(in: &cancellationToken)
        
    }
    
    func fetchUsersChallenges(id: String, completion: @escaping (Result<ChallengeResponse, RequestError>) -> Void) {
        VitalityAPI.shared.fetchChallenges(requestType: .get, endpoint: .getUsersChallenges(id))?
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
                self.usersChallenges = response.results.filter {$0.challengeProgress == 0}
                self.usersChallengesActive = response.results.filter {$0.challengeProgress == 1}
                self.usersChallengesFinished = response.results.filter {$0.challengeProgress == 2}
                self.usersAllChallenges = response.results
                completion(.success(response))
            })
            .store(in: &cancellationToken)
        
    }
    
    func subscribeToChallenge(challenge: String,completion: @escaping (Result<String, RequestError>) -> Void){
        VitalityAPI.shared.subscribeToChallenge(requestType: .post, endpoint: .subscribeToChallenge(challenge))?
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
                completion(.success(result))
            })
            .store(in: &cancellationToken)
    }
    
    func updateChallenge(challenge: ChallengeResult, progressType: Int, completion: @escaping (Result<String, RequestError>) -> Void){
        VitalityAPI.shared.updateChallenge(requestType: .put, endpoint: .updateChallenge(challenge.id, progressType))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    if(challenge.challengeProgress == 0 || challenge.challengeProgress == 3) {
                        
                        self.challenges.first(where: {$0.id == challenge.id})?.challengeProgress = progressType
                        self.challengesActive = self.challenges.filter {$0.challengeProgress == 1}
                        self.challenges = self.challenges.filter {$0.challengeProgress == 0 || $0.challengeProgress == 3}
                    }
                    if(challenge.challengeProgress == 1){
                        self.challengesActive.first(where: {$0.id == challenge.id})?.challengeProgress = progressType
                        self.challenges = self.challengesActive.filter {$0.challengeProgress == 0 || $0.challengeProgress == 3}
                        self.challengesActive = self.challengesActive.filter {$0.challengeProgress == 1}
                    }
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
                
                
                completion(.success(result))
            })
            .store(in: &cancellationToken)
    }
    
    func getChallenge(id: String, completion: @escaping (Result<ChallengeResult, RequestError>) -> Void) {
        VitalityAPI.shared.getChallenge(requestType: .get, endpoint: .getChallenge(id))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                   break
                case .failure(_):
                    self.getChallenge(id: id) {_ in}
                }
            }, receiveValue: { (response) in
                
                
                self.challenge = response
                completion(.success(response))
                
            })
            .store(in: &cancellationToken)
        
    }
    
}

