//
//  MMProfileViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MMProfileViewController: MMBaseViewController {
    @IBOutlet weak var pickerDateCom: UIDatePicker!
    
    @IBOutlet weak var viewPickerWeek: UIView!
    @IBOutlet weak var viewParentC: UIView!
    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var tfname: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tfHeight: UITextField!
    
    @IBOutlet weak var pickerSelectWeek: UIPickerView!
    @IBOutlet weak var tfwaight: UITextField!
    let picker = UIImagePickerController()
    
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var parentPickerView: UIView!
    
    let framePickerViewDefault:CGRect = .zero
    
    @IBOutlet weak var lblDateOfBirt: UILabel!
    
    var dateTimeString:String = ""
    var dateTime:Date = Date()
    
    var keyboardHeight:CGFloat = 0.0
    var originYDefault:CGFloat = 0.0
    
    var flagUpdateProfile:Bool = false
    
    var imageAvarta:UIImage?
    var strName:String?
    var weidth:Double?
    var height:Double?
    var countWeek:Int = 0
    var selectIndexPickerView:Int = 0
    var minWeek:Int = 0
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        self.originYDefault = self.view.bounds.origin.y
        
        let touchActionDimissKeyBoard = UITapGestureRecognizer(target: self, action: #selector(self.keyboardWillDisappear))
        self.viewParentC.addGestureRecognizer(touchActionDimissKeyBoard)
        
        pickerSelectWeek.delegate = self
        pickerSelectWeek.dataSource = self
        
        
        if imageAvarta != nil {
            self.imgAvarta.image = imageAvarta!
        }
        if strName != nil {
            tfname.text = strName!
        }
        if weidth != nil {
            tfwaight.text = "\(weidth!)"
        }
        
        if height != nil {
            tfHeight.text = "\(height!)"
        }
        let realm = try! Realm()
         self.minWeek = realm.objects(BaseModelHealthy.self).min(ofProperty: "week") as Int? ?? 0
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if self.flagUpdateProfile {
            self.lblDateOfBirt.text = "Tuần thứ"
            self.lblDate.text = "\(countWeek)"
        }
        
    }

    @IBAction func actionClose(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: {
            
        })
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if tfname.text?.length == 0 {
            self.showAler(message: "Bạn chưa nhập tên cún cơm", title: "A hi hi!")
            return
        }
        
        if Double(self.tfHeight.text ?? "0.0") == nil  {
            self.showAler(message: "Bạn chưa nhập chiều cao cho bé", title: "A hi hi!")
            return
        }
        
        if Double(self.tfwaight.text ?? "0.0") == nil  {
            self.showAler(message: "Bạn chưa nhập cân nặng cho bé", title: "A hi hi!")
            return
        }
        
        if self.imgAvarta.image == nil {
            return
        } else {
        UserDefaults.set(UIImageJPEGRepresentation(self.imgAvarta.image!, 0.8), forKey: "keyImage")
            
        }

        
        let realm = try! Realm()
        
        let healthyModel:BaseModelHealthy = BaseModelHealthy()
        
        
        let fs = FengShui(checnkg: .VN)
        let dateUI = NSDate()
        let countDay = fs.SubtractionDateWithTowMonth(firstDate: dateTime, secondDate: dateUI as Date)
//        self.countWeek =
        
        healthyModel.height = Double(tfHeight.text ?? "0.0")!
        healthyModel.weight = Double(tfwaight.text ?? "0.0")!
        healthyModel.date = dateTimeString
        if self.flagUpdateProfile {
           healthyModel.week = self.countWeek
           healthyModel.id = healthyModel.incrementID(modelName: BaseModelHealthy.self)
        } else {
            let cont = countDay/7
            
            if countDay%7 != 0 {
                healthyModel.week = cont + 1
            } else {
                
                healthyModel.week = cont
            }
            healthyModel.id = 1
        }
        
        
        
        healthyModel.name = tfname.text ?? ""
        

        
        UserDefaults.set(healthyModel.name, forKey: DataConfig.udKeyName)
        if !self.flagUpdateProfile {
           UserDefaults.set(dateTime, forKey: DataConfig.udBirtDay)
        }
        
        lblDate.text = dateTimeString
        try! realm.write {
            realm.add(healthyModel)
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
        if self.flagUpdateProfile {
            self.lblDate.text = "\(self.countWeek - self.selectIndexPickerView)"
        } else {
            dateTime = self.pickerDateCom.date
            dateTimeString = "\(dateTime.year)-\(dateTime.month)-\(dateTime.day)"
            
            self.lblDate.text = "\(dateTimeString)"
        }
        
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
        
        if self.flagUpdateProfile {
            self.viewPickerWeek.isHidden = false
        } else {
            self.viewPickerWeek.isHidden = true
        }
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

extension MMProfileViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (self.countWeek + 1) - self.minWeek
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Tuần \(self.countWeek - row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("===== \(row)")
        self.selectIndexPickerView = row
    }

}
extension MMProfileViewController {
    @objc func keyboardWillDisappear()  {
        print("====== DisAppear")
        self.view.bounds.origin.y = self.originYDefault
        self.view.endEditing(true)
    }
   @objc func keyboardWillAppear(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height != 0 {
             keyboardHeight = keyboardSize.height
            }
            
            print("==== \(keyboardHeight)")
            self.view.bounds.origin.y = self.originYDefault + keyboardHeight
        }
    }
    
}
