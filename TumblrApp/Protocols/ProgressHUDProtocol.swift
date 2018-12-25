//
//  ProgressHUDProtocol.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import SVProgressHUD

protocol ProgressHudProtocol {
    func show()
    func close()
}

extension ProgressHudProtocol {
    func show() {
        configureColor()
        SVProgressHUD.show()
    }
    
    func showWith(status: String) {
        SVProgressHUD.show(withStatus: status)
    }
    
    func close() {
        SVProgressHUD.dismiss()
    }
}

private extension ProgressHudProtocol {
    func configureColor() {
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setForegroundColor(UIColor.white)
    }
}
