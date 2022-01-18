//
//  LoginViewModel.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/19/21.
//

import Foundation
import KeychainAccess
import Combine
import SwiftUI
import Alamofire
final class LoginViewModel: ObservableObject {
    
    static let loginVM = LoginViewModel()
    @Published var isAuthenticated: Bool = false
    @Published var needsToFillInProfile: Bool = false
    @Published var needsToFillInProfile2: Bool = false
    @Published var confirmationRegistration: Bool = false
    var registerEmail : String = ""
    var cancellationToken = Set<AnyCancellable>()
    private let keychain = Keychain()
    private var accessTokenKeyChainKey = "accessToken"
    private var refreshTokenKeyChainKey = "refreshToken"
    var accessToken: String? {
        get {
            try? keychain.get(accessTokenKeyChainKey)
        }
        set(newValue) {
            guard let accessToken = newValue else {
                try? keychain.remove(accessTokenKeyChainKey)
                isAuthenticated = false
                return
            }
            try? keychain.set("Bearer \(accessToken)", key: accessTokenKeyChainKey)
            isAuthenticated = true
        }
    }
    
    var refreshToken: String? {
        get{
            try? keychain.get(refreshTokenKeyChainKey)
        }
        set(newValue){
            guard let refreshToken = newValue else{
                try? keychain.remove(refreshTokenKeyChainKey)
                return
            }
            try? keychain.set("\(refreshToken)", key: refreshTokenKeyChainKey)
        }
    }
    
    init() {
        isAuthenticated = accessToken != nil
    }
}

extension LoginViewModel {
    
    func login(for login: Login, completion: @escaping (Result<LoginResponse, RequestError>) -> Void) {
        VitalityAPI.shared.login(requestType: .post, endpoint: .login, login: login)?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
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
                self.accessToken = result.AccessToken
                self.refreshToken = result.RefreshToken
                completion(.success(result))
            })
            .store(in: &cancellationToken)
    }
    
    func refreshAccessToken(token: String, completion: @escaping (Result<LoginResponse, RequestError>) -> Void) {
        VitalityAPI.shared.refreshToken(requestType: .post, endpoint: .refreshToken(token))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
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
                self.accessToken = result.AccessToken
                self.refreshToken = result.RefreshToken
                completion(.success(result))
            })
            .store(in: &cancellationToken)
    }
    
    func register(register: Register, endpoint: EndpointType,  completion: @escaping (Result<Data, Error>) -> Void) {
        let stringURL = BaseURL.url + endpoint.urlExtension
        let parameters = ["Email": register.email, "Password": register.password]
        
        AF.request(stringURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData(emptyResponseCodes: [201, 204, 205]){ response in
            switch(response.result) {
            case .success(let result):
                self.needsToFillInProfile = true
                self.registerEmail = register.email
                UserDefaults.standard.set(true, forKey: "needsToFillInProfile")
                completion(.success(result))
                
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
    
    func updateProfile(profile: Profile, endpoint: EndpointType,  completion: @escaping (Result<String, Error>) -> Void) {
        let stringURL = BaseURL.url + endpoint.urlExtension
        let parameters = ["firstname": profile.firstName, "lastname": profile.lastName, "jobTitle": profile.jobTitle, "location": profile.location]
        
        let headers: HTTPHeaders = [
            .authorization(LoginViewModel.loginVM.accessToken ?? " "),
            .accept("application/json")
            
        ]
        AF.upload(multipartFormData: { (multiFormData) in
            for (key, value) in parameters {
                multiFormData.append(Data(value.utf8), withName: key)
            }
        }, to: stringURL, method: .put, headers: headers).validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    self.needsToFillInProfile = false
                    self.needsToFillInProfile2 = true
                    UserDefaults.standard.set(false, forKey: "needsToFillInProfile")

                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
    }
    
    func updateProfileComplete(uiImage: UIImage, profile: ProfileComplete, endpoint: EndpointType,  completion: @escaping (Result<Data, Error>) -> Void) {
        
        let stringURL = BaseURL.url + endpoint.urlExtension
        let parameters = ["firstname": profile.firstName, "lastname": profile.lastName, "jobTitle": profile.jobTitle, "location": profile.location, "description": profile.description]
        
        let headers: HTTPHeaders = [
            .authorization(LoginViewModel.loginVM.accessToken ?? " "),
            .accept("application/json")
            
        ]
        if(uiImage.size.width != 0){
            let imageData = uiImage.jpegData(compressionQuality: 0.5)!
            AF.upload(multipartFormData: { (multiFormData) in
                for (key, value) in parameters {
                    multiFormData.append(Data(value.utf8), withName: key)
                }
                multiFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                
            }, to: stringURL, method: .put, headers: headers).responseData(emptyResponseCodes: [200, 201, 204, 205]){ response in
                switch response.result {
                case .success(let result):
                    self.needsToFillInProfile2 = false
                    
                    completion(.success(result))
                  
                case .failure(let error):
                    
                    completion(.failure(error))
                    
                }
            }
        }
        else{
            AF.upload(multipartFormData: { (multiFormData) in
                for (key, value) in parameters {
                    multiFormData.append(Data(value.utf8), withName: key)
                }
            }, to: stringURL, method: .put, headers: headers).responseData(emptyResponseCodes: [200, 201, 204, 205]){ response in
                switch response.result {
                case .success(let result):
                    self.needsToFillInProfile2 = false
                    
                    completion(.success(result))
                case .failure(let error):
                
                    completion(.failure(error))
                    
                }
            }
        }
    }
    
    
    func logout() {
        accessToken = nil
        refreshToken = nil
        UserViewModel.userVM.offset = 0
        UserViewModel.userVM.offsetSearch = 0
        UserViewModel.userVM.offsetScorebord = 0
    }
}
