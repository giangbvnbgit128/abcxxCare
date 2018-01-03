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

    @IBOutlet weak var imgAvarta: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var tfLinkVideo: UITextField!
    
    let picker = UIImagePickerController()
    
    var noteName:String = ""
    var idForItem:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgAvarta.layer.cornerRadius = 15
        imgAvarta.border(color: .black, radius: 15, width: 1)
        picker.delegate = self
        
//        let urlImage = URL(string: "https://firebasestorage.googleapis.com/v0/b/managericare-7b947.appspot.com/o/carImages%2F1514516925.4317.jpg?alt=media&token=fe54ccb3-1e6c-49c0-8db9-34308d070472")
        
//        imgAvarta.sd_setImage(with: urlImage, completed: nil)
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
//        self.ref.child("dbhealth").child(self.noteName).setValue()
       
        let imageLoader = ImageUploadManager()
        let imageAvarta:UIImage = self.imgAvarta.image!
        imageLoader.uploadImage(imageAvarta, progressBlock: { (persented) in
            print("persent == \(persented)")
        }) { (url, error) in
            let mm = MMHealthModel()
            mm.id = self.idForItem
            mm.content = self.txtContent.text
            mm.title = self.tfTitle.text ?? ""
            mm.urlImage = "\(url!)"
            mm.urlWeb =  ""
            mm.urlVideo = self.tfLinkVideo.text ?? ""
            
            
            let post = ["id": mm.id,
                        "content": mm.content,
                        "title": mm.title,
                        "urlimage": mm.urlImage,
                        "urlweb": mm.urlWeb,
                        "urlvideo": mm.urlVideo] as [String : Any]
            self.ref.child("dbhealth").child(self.noteName).child(mm.title).setValue(post)
        }

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
