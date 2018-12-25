//
//  ViewController.swift
//  TumblrApp
//
//  Created by Sasha on 21.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol LoginView: class {
    func didLogin()
}

final class LoginViewController: UIViewController {
    
    //MARK: Variables
    
    private var presenter = LoginPresenter()
    
    //MARK: LoginViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.checkIfUserHasAlreadyLogged()
    }
}

//MARK: LoginView Delegate

extension LoginViewController: LoginView {
    func didLogin() {
        let containerViewController: ContainerViewController = UIStoryboard.getStoryboard(by: .menu).instantiateViewController()
        navigationController?.pushViewController(containerViewController, animated: true)
    }
}

//MARK: @IBActions

private extension LoginViewController {
    @IBAction func loginButtonDidTapped(_ sender: UIButton) {
        presenter.login()
    }
}

