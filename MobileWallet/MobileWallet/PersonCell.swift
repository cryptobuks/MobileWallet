//
//  PersonCell.swift
//  MobileWallet
//
//  Created by xszhao on 2017-03-31.
//  Copyright © 2017 xszhao. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    var flagImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        self.setupSubviews()
        self.autolayoutSubviews()
        fatalError("init(coder:) has not been implemented")
    }
    
    func autolayoutSubviews() {
        self.flagImageView!.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.0).isActive = true
        self.flagImageView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 2.0).isActive = true
        self.flagImageView!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2.0).isActive = true
        self.flagImageView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2.0).isActive = true
    }
    
    func setupSubviews() {
        self.flagImageView = UIImageView()
        self.flagImageView!.translatesAutoresizingMaskIntoConstraints = false
        self.flagImageView!.contentMode = .scaleAspectFill
        self.flagImageView!.clipsToBounds = true
        self.contentView.addSubview(self.flagImageView!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.flagImageView!.image = nil
    }
    

}
