//
//  TopMenuCell.swift
//  Blogy2
//
//  Created by admin on 30/09/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
//    let imageName: String
    
    init(name: String) {
        self.name = name
//        self.imageName = imageName
    }
}

class TopMenuCell: UICollectionViewCell {
    
    var setting: Setting? {
        didSet {
            titleLabel.text = setting?.name
            
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor(red: 48/255, green: 53/255, blue: 59/255, alpha: 1) : UIColor(red: 48/255, green: 53/255, blue: 59/255, alpha: 0.7)
        }
    }
    
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "testL"
        lbl.textColor = UIColor(red: 48/255, green: 53/255, blue: 59/255, alpha: 0.70)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
//        titleLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleLabel.fillSuperview()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
