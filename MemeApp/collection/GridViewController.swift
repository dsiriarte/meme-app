//
//  GridViewController.swift
//  MemeApp
//
//  Created by David Iriarte on 15/06/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import Foundation
import UIKit

class GridViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Collection View Data Source
    @IBOutlet var collectionViewController: UICollectionView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionViewController.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimensionWidth = (view.frame.size.width - (2 * space)) / 3.0
        let dimensionHeight = (view.frame.size.height) / 7.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionWidth, height: dimensionHeight)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeGridCell", for: indexPath) as! MemeGridCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.memeImageView?.image = meme.memedImage
        //cell.schemeLabel.text = "Scheme: \(villain.evilScheme)"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.modalPresentationStyle = .fullScreen
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.present(detailController,animated: true,completion: nil)
    }
}
