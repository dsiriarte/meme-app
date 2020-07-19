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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ListViewCell.self, forCellReuseIdentifier : "MemeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func createMeme(_ sender: Any) {
        let createController = storyboard?.instantiateViewController(withIdentifier: "CreateMemeViewController") as! CreateMemeViewController
        createController.modalPresentationStyle = .fullScreen
        self.present(createController,animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! ListViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.meme = meme
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.modalPresentationStyle = .fullScreen
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.present(detailController,animated: true,completion: nil)
    }
    
}
