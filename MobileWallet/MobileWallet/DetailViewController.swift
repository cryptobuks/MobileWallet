//
//  DetailViewController.swift
//  MobileWallet
//
//  Created by xszhao on 2017-03-31.
//  Copyright © 2017 xszhao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var portraitImageView: UIImageView?
    var imageName: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupSubviews() {
        self.portraitImageView = UIImageView()
        self.portraitImageView!.translatesAutoresizingMaskIntoConstraints = false
        self.portraitImageView!.contentMode = .scaleAspectFit
        self.portraitImageView!.clipsToBounds = true
        
        if self.imageName != nil {
            self.portraitImageView!.image = UIImage(named: self.imageName!)
        }
        
        self.view.addSubview(self.portraitImageView!)
    }
    
    func autolayoutSubviews() {
        self.portraitImageView!.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        self.portraitImageView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.portraitImageView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.portraitImageView!.bottomAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    }
}
