//
//  ViewController.swift
//  DynamicUICollectionView
//
//  Created by Ponraj, Rooban (Rooban Abraham) on 28/05/20.
//  Copyright © 2020 Rooban Abraham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let paddingConstant: CGFloat = 40 // 40 is padding for cell
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    let items: [AccountItem] = [
        AccountItem(accountName: "Checking 1234 - Primary checking account linked with P2P", accountBalance:"$5000"),
        AccountItem(accountName: "Saving 1234 - Primary saving account linked with investment", accountBalance:"$5000"),
        AccountItem(accountName: "Saving 1234", accountBalance:"$5000")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.reloadCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadCollectionView), name: UIContentSizeCategory.didChangeNotification, object: nil)
     }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
     }

     @objc func reloadCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   self.collectionView.reloadInputViews()
                   self.collectionView.reloadData()
                   self.collectionView.reloadSections(IndexSet(integersIn: 0...0))
               }
     }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.reloadCollectionView()
    }
}

// MARK: - Collection view delegate and data source methods

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        cell.cellWidth.constant = collectionView.frame.width - paddingConstant
        cell.accountLabel.text = items[indexPath.item].accountName
        cell.amountLabel.text = items[indexPath.item].accountBalance
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.maxWidth = collectionView.bounds.width - paddingConstant
        cell.setNeedsUpdateConstraints()
        
        return cell
    }
}

