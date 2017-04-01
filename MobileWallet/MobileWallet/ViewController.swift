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
    var longPressGestureRecognizer: UILongPressGestureRecognizer?
    var currentDragAndDropIndexPath: NSIndexPath?
    var currentDragAndDropSnapshot: UIView?
    
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
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        self.longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognizerAction:")
        self.longPressGestureRecognizer!.isEnabled = false
        self.collectionView!.addGestureRecognizer(self.longPressGestureRecognizer!)
        
        
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.collectionView!.allowsMultipleSelection = editing
        let indexPaths: [NSIndexPath] = self.collectionView!.indexPathsForVisibleItems as [NSIndexPath]
        
        for indexPath in indexPaths {
            self.collectionView!.deselectItem(at: indexPath as IndexPath, animated: false)
            let cell: PersonCell? = self.collectionView!.cellForItem(at: indexPath as IndexPath) as? PersonCell
            cell?.editing = editing
        }
        
        if editing {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: "deleteSelectedItemsAction:")
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PersonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as! PersonCell
        
        let currentPerson: Person = self.persons![indexPath.row]
        cell.flagImageView!.image = UIImage(named: currentPerson.flagImageName)
        
        return cell
    }

    func updateDragAndDropSnapshotView(alpha: CGFloat, center: CGPoint, transform: CGAffineTransform) {
        if self.currentDragAndDropSnapshot != nil {
            self.currentDragAndDropSnapshot!.alpha = alpha
            self.currentDragAndDropSnapshot!.center = center
            self.currentDragAndDropSnapshot!.transform = transform
        }
    }
    
    func longPressGestureRecognizerAction(sender: UILongPressGestureRecognizer) {
        let currentLocation = sender.location(in: self.collectionView!)
        let indexPathForLocation: NSIndexPath? = self.collectionView!.indexPathForItem(at: currentLocation) as NSIndexPath?
        
        switch sender.state {
        case .began:
            if indexPathForLocation != nil {
                self.currentDragAndDropIndexPath = indexPathForLocation
                let cell: PersonCell? = self.collectionView!.cellForItem(at: indexPathForLocation as! IndexPath) as! PersonCell?
                self.currentDragAndDropSnapshot = cell!.snapshot
                self.updateDragAndDropSnapshotView(alpha: 0.0, center: cell!.center, transform: CGAffineTransform.identity)
                self.collectionView!.addSubview(self.currentDragAndDropSnapshot!)
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.updateDragAndDropSnapshotView(alpha: 0.95, center: cell!.center, transform: CGAffineTransform(scaleX: 1.05, y: 1.05))
                    cell!.isMoving = true
                })
            }
        case .changed:
            self.currentDragAndDropSnapshot!.center = currentLocation
            if indexPathForLocation != nil {
                let person:Person = self.persons![self.currentDragAndDropIndexPath!.row]
                self.persons!.remove(at: self.currentDragAndDropIndexPath!.row)
                self.persons!.insert(person, at: indexPathForLocation!.row)
                self.collectionView!.moveItem(at: self.currentDragAndDropIndexPath as! IndexPath, to: indexPathForLocation! as IndexPath)
                self.currentDragAndDropIndexPath = indexPathForLocation
            }
            
        default:
            print("default")
            let cell: PersonCell? = self.collectionView!.cellForItem(at: indexPathForLocation! as IndexPath) as? PersonCell
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.updateDragAndDropSnapshotView(alpha: 0.0, center: cell!.center, transform: CGAffineTransform.identity)
                cell!.isMoving = false
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

