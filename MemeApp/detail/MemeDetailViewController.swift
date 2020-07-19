//
//  MemeDetailViewController.swift
//  MemeApp
//
//  Created by David Iriarte on 18/07/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    
    var meme : Meme? = nil
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        image.image = meme?.memedImage
    }

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
