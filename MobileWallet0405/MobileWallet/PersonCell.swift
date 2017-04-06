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
    var checkboxImageView: UIImageView?
    var collectionView: UICollectionView?
    
    
    var editing: Bool = false {
        didSet {
            self.checkboxImageView!.isHidden = !editing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if editing {
                self.checkboxImageView!.image = UIImage(named: isSelected ? "checked" : "unchecked") 
            }
        }
    }
    
    var isMoving: Bool = false {
        didSet {
            self.flagImageView!.alpha = isMoving ? 0.0 : 1.0
            self.checkboxImageView!.alpha = isMoving ? 0.0 : 1.0
            self.backgroundColor = isMoving ? UIColor.clear : UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        }
    }
    
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
    
    var snapshot: UIView {
        let snapshot: UIView = self.snapshotView(afterScreenUpdates: true)!
        let layer: CALayer = snapshot.layer
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -4.0, height: 0.0)
        return snapshot
    }
    
    func setupSubviews() {
        self.flagImageView = UIImageView()
        self.flagImageView!.translatesAutoresizingMaskIntoConstraints = false
        self.flagImageView!.contentMode = .scaleAspectFill
        self.flagImageView!.clipsToBounds = true
        self.contentView.addSubview(self.flagImageView!)
        
        self.checkboxImageView = UIImageView()
        self.checkboxImageView!.translatesAutoresizingMaskIntoConstraints = false
        self.checkboxImageView!.contentMode = .scaleAspectFit
        self.checkboxImageView!.clipsToBounds = true
        self.checkboxImageView!.isHidden = true
        self.checkboxImageView!.image = UIImage(named: "unchecked")
        self.contentView.addSubview(self.checkboxImageView!)
    }
    
    func autolayoutSubviews() {
        self.flagImageView!.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2.0).isActive = true
        self.flagImageView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 2.0).isActive = true
        self.flagImageView!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2.0).isActive = true
        self.flagImageView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2.0).isActive = true
        
        self.checkboxImageView!.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.checkboxImageView!.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.checkboxImageView!.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.checkboxImageView!.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.flagImageView!.image = nil
        self.checkboxImageView!.isHidden = true
    }
    
}
