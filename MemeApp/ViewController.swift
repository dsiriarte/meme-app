//
//  ViewController.swift
//  MemeApp
//
//  Created by David Iriarte on 30/03/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var footToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    
    private let topTextFieldDelegate = TopTextFieldDelegate()
    private let bottomTextFieldDelegate = BottomTextFieldDelegate()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setUpTextFields()
        shareBtn.isEnabled = false
    }
    
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage =  generateMemedImage()
        let viewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(viewController,animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    private func setUpTextFields(){
        topTextField.delegate = topTextFieldDelegate
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        topTextField.text = Constants.DEFAULT_TOP_TEXT
        topTextField.textColor = UIColor.white
        
        bottomTextField.delegate = bottomTextFieldDelegate
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        bottomTextField.text = Constants.DEFAULT_BOTTOM_TEXT
        bottomTextField.textColor = UIColor.white
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func canelBtnClicked(_ sender: Any) {
        reset()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        imageView.image = image
        shareBtn.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    private func generateMemedImage() -> UIImage {
        
        prepareForScreenshot()
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        setupAfterScreenshot()
        
        let imageFrame = imageView.frame
        return crop(memedImage, rect: CGRect(x: imageFrame.origin.x, y: imageFrame.origin.y, width: imageFrame.width, height: imageFrame.height))
    }
    
    private func prepareForScreenshot(){
        hideToolbars()
        if topTextField.text == Constants.DEFAULT_TOP_TEXT {
            topTextField.text = ""
        }
        if bottomTextField.text == Constants.DEFAULT_BOTTOM_TEXT {
            bottomTextField.text = ""
        }
    }
    
    private func setupAfterScreenshot(){
        showToolbars()
        if topTextField.text == "" {
            topTextField.text = Constants.DEFAULT_TOP_TEXT
        }
        if bottomTextField.text == ""{
            bottomTextField.text = Constants.DEFAULT_BOTTOM_TEXT
        }
    }
    
    private func showToolbars(){
        footToolbar.isHidden = false
        topToolbar.isHidden = false
    }
    private func hideToolbars(){
        footToolbar.isHidden = true
        topToolbar.isHidden = true
    }
    
    private func crop(_ image : UIImage, rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=image.scale
        rect.origin.y*=image.scale
        rect.size.width*=image.scale
        rect.size.height*=image.scale
        
        let imageRef = image.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: image.scale, orientation: image.imageOrientation)
        return image
    }
    
    private func reset(){
        imageView.image = nil
        topTextField.text =  Constants.DEFAULT_TOP_TEXT
        bottomTextField.text =  Constants.DEFAULT_BOTTOM_TEXT
        shareBtn.isEnabled = false
    }
    
}

