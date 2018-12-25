//
//  LoginPresenter.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

final class LoginPresenter  {
    
    //MARK: Variables
    
    private var authService = OAuthService()
    
    weak var delegate: (LoginView & AlertDisplayable)?
    
    //MARK: Public Methods
    
    func login() {
        authService.authorize { [weak self] error in
            if let error = error {
                 self?.delegate?.showAlert(with: error)
            } else {
                  self?.delegate?.didLogin()
            }
        }
    }
    
    func checkIfUserHasAlreadyLogged() {
        if  UserDefaults.standard.oauthToken != nil {
            delegate?.didLogin()
        }
    }
}
