//
//  ViewController.swift
//  MobileWallet
//
//  Created by xszhao on 2017-03-31.
//  Copyright © 2017 xszhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView?
    var persons: [Person]?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.demoData()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.demoData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.demoData()
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    func demoData() {
        let person1: Person = Person(name: "Angela Merkel", portraitImageName: "merkel", flagImageName: "ger")
        let person2: Person = Person(name: "Barack Obama", portraitImageName: "obama", flagImageName: "us")
        let person3: Person = Person(name: "David Cameron", portraitImageName: "cameron", flagImageName: "gb")
        let person4: Person = Person(name: "Vladimir Putin", portraitImageName: "putin", flagImageName: "rus")
        
        self.persons = [person1, person2, person3, person4]
    }
    
    func setupSubviews() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        flowLayout.itemSize = CGSize(width: 145.0, height: 97.0)
        //flowLayout.scrollDirection = .horizontal
            
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView!.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView!.dataSource = self
        self.collectionView!.delegate = self
        self.collectionView!.register(PersonCell.self, forCellWithReuseIdentifier: "PersonCell")
        self.collectionView?.backgroundColor = UIColor.white
        
        self.view.addSubview(self.collectionView!) //don't forget to add this to UI
    }
    
    func autolayoutSubviews() {
        self.collectionView!.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if persons != nil {
            return self.persons!.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PersonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        
        let currentPerson: Person = self.persons![indexPath.row]
        cell.flagImageView!.image = UIImage(named: currentPerson.flagImageName)
        
        return cell
    }

    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

