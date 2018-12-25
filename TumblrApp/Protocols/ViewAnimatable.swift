//
//  ViewAnimatable.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol ViewAnimatable where Self: UIViewController {
    func animateLayoutIfNeeded(with duration: TimeInterval)
}

extension ViewAnimatable {
    func animateLayoutIfNeeded(with duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
