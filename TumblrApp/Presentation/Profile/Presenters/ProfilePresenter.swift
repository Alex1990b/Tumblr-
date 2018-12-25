//
//  ProfilePresenter.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

final class ProfilePresenter {
    
    //MARK: Constants
    
    private let networkService = ProfileNetworkService()
    
    //MARK: Variables
    
    weak var delegate: (ProfileView & AlertDisplayable)?
    private var user: User!
    
    //MARK: Public Methods
    
    func fetchUserInfo() {
        
        if  Connectivity.isConnectedToInternet() {
            
            networkService.fetchUserInfo { [weak self] (response, error) in
                
                guard let strongSelf =  self else { return }
                
                if let error = error {
                    strongSelf.delegate?.showAlert(with: error)
                }
                
                if let user = response?.response.user {
                    strongSelf.user = user
                    CoreDataService.shared.deleteAllRecords(entity: User.self)
                    CoreDataService.shared.saveContext()
                    self?.delegate?.update(with: user)
                }
            }
        } else {
            if let user = CoreDataService.shared.fetchData(entity: User.self)  {
                self.user = user.first
                delegate?.update(with: self.user)
            }
        }
    }
}
