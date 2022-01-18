//
//  ProfileViewModel.swift
//  inholland-vitality-ios
//
//  Created by user206680 on 11/23/21.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    
    static let profileVM = ProfileViewModel()
    var cancellationToken = Set<AnyCancellable>()
    
}

extension ProfileViewModel {
    
    func updateProfile(for profile: Profile, completion: @escaping (Result<ProfileResponse, RequestError>) -> Void) {
        VitalityAPI.shared.updateProfile(profile: profile, endpoint: .register)
    }
}
