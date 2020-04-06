//
//  TopTextFieldDelegate.swift
//  MemeApp
//
//  Created by David Iriarte on 4/04/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == Constants.DEFAULT_TOP_TEXT {
            textField.text=""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      if textField.text == "" {
                   textField.text = Constants.DEFAULT_TOP_TEXT
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
