//
//  AddViewController.swift
//  Day7
//
//  Created by admin on 7/23/18.
//  Copyright © 2018 meosteam. All rights reserved.
//

import UIKit

/// Add new contact viewcontroller
class AddViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var tfPhone: UITextField!
    
    // MARK: - constans
    var imagePicker = UIImagePickerController()
    var contact : Contacts?

    
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        contact = Contacts(context: context)
    }
    
    // MARK: - action
    @IBAction func actionChoseAvatar(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if let name = tfName.text, let phone = tfPhone.text{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            contact?.name = name
            contact?.phone = phone
            DatabaseManager.instanle.insert(contact: contact!, context: context)
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Delegate
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageAvatar.contentMode = .scaleAspectFit //3
        imageAvatar.image = chosenImage //4
        let data = UIImageJPEGRepresentation(chosenImage, 1)
        contact?.avatar = data
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
