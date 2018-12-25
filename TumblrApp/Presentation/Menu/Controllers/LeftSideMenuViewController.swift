//
//  LeftSideMenyViewController.swift
//  CustomSideMenu
//
//  Created by Sasha on 13.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

protocol SideMenuDraggable: class {
    func dragChanged(with offset: CGFloat)
    func dragEnded(with offset: CGFloat)
    func dragFinished()
}

protocol LeftMenuView: class {
    func update()
    func showViewController(with type: LeftMenuModel.ItemType)
}

final class LeftSideMenuViewController: UIViewController {
    
    //MARK:  @IBOutlets

    @IBOutlet private weak var menuTableView: UITableView!
    
    //MARK: Variables
    private var dragBeginning = TimeInterval()
    weak var delegate: (SideMenuDraggable & Routable)?
    
    //MARK: Constants
    
    private let presenter = LeftMenuPresenter()
    
    //MARK: LeftSideMenyViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        addRecognizers()
        configureTableView()
        presenter.fetchMenuItems()
    }
}

//MARK: LeftMenuView Delegate

extension LeftSideMenuViewController: LeftMenuView {
    func update() {
        menuTableView.reloadData()
    }
    
    func showViewController(with type: LeftMenuModel.ItemType) {
        delegate?.addChildViewController(with: type)
    }
}

//MARK: @IBActions

private extension LeftSideMenuViewController {
    
    @objc func handleDragges(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.x < 0 else { return }
        
        switch sender.state {
        case .began:   dragBeginning = ProcessInfo.processInfo.systemUptime
        case .changed: delegate?.dragChanged(with: translation.x)
        case.ended:
            let difference = ProcessInfo.processInfo.systemUptime - dragBeginning
            difference > 0.1 ? delegate?.dragEnded(with: translation.x) : delegate?.dragFinished()
            
        default: break }
    }
}

//MARK: Private methods

private extension LeftSideMenuViewController {
    func configureTableView() {
        menuTableView.register(LeftMenuTableViewCell.self)
        menuTableView.delegate = presenter.tableViewGenerator
        menuTableView.dataSource = presenter.tableViewGenerator
    }
    
    func addRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDragges))
        view.addGestureRecognizer(panGestureRecognizer)
    }
}
