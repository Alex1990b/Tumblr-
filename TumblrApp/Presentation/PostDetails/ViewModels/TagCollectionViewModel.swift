//
//  TagCollectionViewModel.swift
//  TumblrApp
//
//  Created by Alex on 24.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

final class TagCollectionViewModel: NSObject {
    
    //MARK: Variables
    
    var tags = [String]()
}

//MARK: UICollectionViewDataSource

extension TagCollectionViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TagCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.title = tags[indexPath.row]
        
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension TagCollectionViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = tags[indexPath.row].size(withAttributes:[.font: UIFont.systemFont(ofSize: 17.0)])
        return CGSize(width: size.width + 40, height: 30)
    }
}


