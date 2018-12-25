//
//  ViewController.swift
//  CustomSideMenu
//
//  Created by Sasha on 13.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol Routable: class {
    func addChildViewController(with type: LeftMenuModel.ItemType)
}

final class ContainerViewController: UIViewController, ViewAnimatable {
    
    //MARK: @IBOutlets
    
    @IBOutlet private weak var leftMenuContainerView: UIView!
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var leftMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var overlayView: UIView!
    
    //MARK: Variables
    
    private var leftMenuWidth: CGFloat {
        return view.frame.width * 0.6
    }
    
    //MARK: Constants
    
    private let overlayViewMaxAlpha: CGFloat = 0.3
    private let overlayViewMinAlpha: CGFloat = 0
    
    //MARK: MainViewController Life Cycle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeLeftMenu()
        showNavigationBar()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(overlayViewDidTapped))
        overlayView.addGestureRecognizer(tapGestureRecognizer)
        children.forEach { ($0 as? LeftSideMenuViewController)?.delegate = self }
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: Actions

private extension ContainerViewController {
    @IBAction func showLeftMenuButtonTapped(_ sender: UIBarButtonItem) {
        leftMenuLeadingConstraint.constant = leftMenuLeadingConstraint.constant < 0 ? 0 : -leftMenuWidth
        overlayView.alpha = leftMenuLeadingConstraint.constant == 0 ? overlayViewMaxAlpha : overlayViewMinAlpha
        animateLayoutIfNeeded()
    }
    
    @objc func overlayViewDidTapped() {
        closeLeftMenu()
    }
    
    @objc func rotated() {
        leftMenuLeadingConstraint.constant = leftMenuLeadingConstraint.constant < 0 ? -leftMenuWidth : 0
    }
}

//MARK: Private methods

private extension ContainerViewController {
    func closeLeftMenu() {
        leftMenuLeadingConstraint.constant = -leftMenuWidth
        overlayView.alpha = 0
        animateLayoutIfNeeded()
    }
    
    func addChild(viewController: UIViewController) {
        removeChilds()
        addChild(viewController)
        viewController.view.frame = contentContainerView.bounds
        contentContainerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeChilds() {
        children.forEach { (viewController) in
            if !(viewController is LeftSideMenuViewController) {
                viewController.willMove(toParent: nil)
                viewController.view.removeFromSuperview()
                viewController.removeFromParent()
            }
        }
    }
}

//MARK: SideMenuDelegate

extension ContainerViewController: SideMenuDraggable {
    func dragFinished() {
        closeLeftMenu()
    }
    
    func dragChanged(with offset: CGFloat) {
        leftMenuLeadingConstraint.constant = offset
        
        // needed to change alpha depending on the position of the menu
        let currentOffsetInPercent = (offset * 100) / (leftMenuWidth)
        let currentAlphaOffset = (0.5 * currentOffsetInPercent) / 100
        
        overlayView.alpha =  overlayViewMaxAlpha - currentAlphaOffset.magnitude
        animateLayoutIfNeeded()
    }
    
    func dragEnded(with offset: CGFloat) {
        
        if  offset.magnitude <= (leftMenuWidth / 2) {
            leftMenuLeadingConstraint.constant = 0
        } else {
            leftMenuLeadingConstraint.constant = -leftMenuWidth
        }
        
        overlayView.alpha = leftMenuLeadingConstraint.constant == 0 ? overlayViewMaxAlpha : overlayViewMinAlpha
        animateLayoutIfNeeded()
    }
}

//MARK: Routable

extension ContainerViewController: Routable {
    func addChildViewController(with type: LeftMenuModel.ItemType) {
        
        closeLeftMenu()
        if type == .profile {
            let profileViewController: ProfileViewController = UIStoryboard.getStoryboard(by: .profile).instantiateViewController()
            addChild(viewController: profileViewController)
        } else {
            let postsViewController: PostsViewController = UIStoryboard.getStoryboard(by: .menu).instantiateViewController()
            addChild(viewController: postsViewController)
        }
    }
}

