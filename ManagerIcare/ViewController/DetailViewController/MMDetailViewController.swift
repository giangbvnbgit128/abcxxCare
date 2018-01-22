//
//  MMDetailViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/24/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MMDetailViewController: MMBaseViewController {

    @IBOutlet weak var tflinkImage: UITextField!
    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var tfLinkVideo: UITextField!
    @IBOutlet weak var tflinkWeb: UITextField!
    
    let picker = UIImagePickerController()
    
    var noteName:String = ""
    var idForItem:Int = 0
    var keyDataBase:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAvarta.layer.cornerRadius = 15
        imgAvarta.border(color: .black, radius: 15, width: 0.2)
        picker.delegate = self
        self.txtContent.border(color: .black, radius: 15, width: 0.2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UploadImage() {
        // upload image form iphone
        
    }
    func uploadData(complete: @escaping() -> Void)  {
        
    }
    @IBAction func tabImageAvarta(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    }
    @IBAction func SaveAction(_ sender: Any) {
            let mm = MMHealthModel()
            mm.id = self.idForItem
            mm.content = (self.txtContent.text ?? "")
            mm.title = (self.tfTitle.text ?? "")
            if self.tflinkImage.text != nil {
                mm.urlImage = (self.tflinkImage.text ?? "")
            }
            
            mm.urlWeb =  (self.tflinkWeb.text ?? "")
            mm.urlVideo = ((self.tfLinkVideo.text ?? "") as String)
            let post = ["id": mm.id,
                        "content": mm.content,
                        "title": mm.title,
                        "urlimage": mm.urlImage,
                        "urlweb": mm.urlWeb,
                        "urlvideo": mm.urlVideo] as [String : Any]
            self.ref.child(self.keyDataBase).child(self.noteName).child(mm.title).setValue(post)
            self.navigationController?.popToRootViewController(animated: true)
    }
}

extension MMDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imgAvarta.contentMode = .scaleAspectFit //3
        imgAvarta.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
    
}
