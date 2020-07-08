//
//  ListViewController.swift
//  MemeApp
//
//  Created by David Iriarte on 15/06/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func createMeme(_ sender: Any) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "CreateMemeViewController") as! CreateMemeViewController
          detailController.modalPresentationStyle = .fullScreen
          self.present(detailController,animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.memes.count
      }
      
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
          let meme = self.memes[(indexPath as NSIndexPath).row]
          
          // Set the name and image
    cell.textLabel?.text = "\(meme.topText) - \(meme.bottomText)"
          cell.imageView?.image = meme.memedImage
          
          return cell
      }

       func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
      }
    
    
}
