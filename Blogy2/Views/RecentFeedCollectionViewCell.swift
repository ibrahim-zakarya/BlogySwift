//
//  RecentFeedCollectionViewCell.swift
//  Blogy2
//
//  Created by admin on 01/10/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class RecentFeedCollectionViewCell: UICollectionViewCell {
    
    var recentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .green
        addSubview(recentCollectionView)
        recentCollectionView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
