//
//  MMProfileViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit
//import DateTimePicker

class MMProfileViewController: UIViewController {
    @IBOutlet weak var pickerDateCom: UIDatePicker!
    
    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tfHeight: UITextField!
    
    @IBOutlet weak var tfwaight: UITextField!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var parentPickerView: UIView!
    
    let framePickerViewDefault:CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgAvarta.layer.cornerRadius = self.imgAvarta.layer.frame.width/2
        self.imgAvarta.border(color: .black, radius: self.imgAvarta.layer.frame.width/2, width: 1)
        picker.delegate = self
        
        if let imageData = UserDefaults.value(forKey: "keyImage") as? Data {
            let IMGE = UIImage(data: imageData)!
            self.imgAvarta.image = IMGE
        }
        
        self.hiddenPickerDateTime()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.hiddenPickerDateTime()
    }

    @IBAction func actionClose(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if self.imgAvarta.image == nil {
            return
        } else {
        UserDefaults.set(UIImageJPEGRepresentation(self.imgAvarta.image!, 100), forKey: "keyImage")
            let dateTime:Date = self.pickerDateCom.date
            print("====== DateSelect =\(dateTime)")
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickActionChooseImage(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    
    }
    
    @IBAction func actionCancelDateTimePicker(_ sender: Any) {
        self.dismissPickerDateTime()
    }
    
    @IBAction func clickDateTime(_ sender: Any) {
        
        self.showPickerDateTime()
    }
    
    @IBAction func actionOkDateTime(_ sender: Any) {
        self.lblDate.text = "\(pickerDateCom.date)"
        self.dismissPickerDateTime()
    }
    func dismissPickerDateTime() {
        UIView.animate(withDuration: 0.2, animations: {
            self.pickerView.frame.origin.y = UIScreen.main.bounds.height
        }) { (complete) in
            self.parentPickerView.isHidden = true
        }
    }
    func hiddenPickerDateTime() {
        self.parentPickerView.isHidden = true
        DispatchQueue.main.async {
            self.pickerView.frame.origin.y = UIScreen.main.bounds.height
        }
    }
    
    func showPickerDateTime() {
        self.parentPickerView.isHidden = false
        self.parentPickerView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.pickerView.frame.origin.y = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.5, animations: {
            self.pickerView.frame.origin.y = UIScreen.main.bounds.height - 250
        }) { (complete) in
            
        }
    }
    
}

extension MMProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imgAvarta.contentMode = .scaleAspectFit //3
        imgAvarta.image = chosenImage //4
        
        UserDefaults.set(UIImageJPEGRepresentation(chosenImage, 100), forKey: "keyImage")
        
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
    
}
