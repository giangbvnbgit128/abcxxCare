//
//  MMAddHealthViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/24/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class MMAddHealthViewController: MMBaseViewController {

    @IBOutlet weak var uitxteditText: UITextField!
    @IBOutlet weak var viewAddNote: UIView!
    @IBOutlet weak var tfName: UITextField!
    
    var idForItem:Int = 0
    
    var arrayNote:[String] = []
    var keyDataBase:String = ""
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewAddNote.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let viewCell = UINib(nibName: headerCellTableViewCell.className, bundle: nil)
        tableView.register( viewCell, forCellReuseIdentifier: headerCellTableViewCell.className)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
       
    }

    @objc func addTapped() {
        self.viewAddNote.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func AddNote(_ sender: Any) {
        if let noteName = uitxteditText.text {
            ref.child(self.keyDataBase).setValue(noteName)
        }
        
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.viewAddNote.isHidden = true
    }
    
    @IBAction func OkAction(_ sender: Any) {
        if (tfName.text ?? "").length > 0 {
            let noteName = tfName.text
            let viewVC = MMDetailViewController()
            viewVC.noteName = noteName ?? "Not null"
            viewVC.keyDataBase = self.keyDataBase
            self.viewAddNote.isHidden = true
            viewVC.idForItem = self.idForItem
            self.navigationController?.pushViewController(viewVC, animated: true)
        }
    }
    
}
extension MMAddHealthViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: headerCellTableViewCell.className) as! headerCellTableViewCell
        cell.lblTitle.text = self.arrayNote[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewVC = MMDetailViewController()
        viewVC.noteName = self.arrayNote[indexPath.row]
        viewVC.idForItem = self.idForItem
        viewVC.keyDataBase = self.keyDataBase
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
 
}
