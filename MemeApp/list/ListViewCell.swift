//
//  ListViewCell.swift
//  MemeApp
//
//  Created by David Iriarte on 16/07/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import UIKit
class ListViewCell : UITableViewCell {
    
    var meme : Meme? {
        didSet {
            memeImage.image = meme?.memedImage
            memeNameLabel.text = "\(meme?.topText ?? "") - \(meme?.bottomText ?? "")"
        }
    }
    
    
    private let memeNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let memeImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(memeImage)
               addSubview(memeNameLabel)
        
        memeImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 100, height: 100, enableInsets: false)
        memeNameLabel.anchor(top: topAnchor, left: memeImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: frame.size.width / 2, height: 0, enableInsets: false)
        memeNameLabel.center = self.center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
