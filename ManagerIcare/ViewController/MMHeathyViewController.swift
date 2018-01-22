//
//  MMHeathyViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/23/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class MMHeathyViewController: MMBaseViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var arrayKey:[String] = []
    var arrayId:[Int] = []
    var arrayGroup:[MMHealthGroup] = []
    var keyDataBase:String = "dbhealth"
    var noteName1:String = "Vắc xin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

        let viewCell = UINib(nibName: MMHealthTableViewCell.className, bundle: nil)
        
        tableview.register( viewCell, forCellReuseIdentifier: MMHealthTableViewCell.className)
        tableview.separatorStyle = .none
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableview.sectionHeaderHeight = 0.0
        self.initHeaderView()

        self.navigationController?.title = "Sức Khoẻ"
        
        if self.navigationController == nil {
            print("navigationController nil")
        } else {
            print("Navigation view controller not nil")
        }
        
//        self.getDataCache() func backup data
        
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        self.clickMenu()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
        
        
        
    }
    @IBAction func AddData(_ sender: Any) {
        print("====== button right")
        let viewVC = MMAddHealthViewController()
        viewVC.edgesForExtendedLayout = []
        viewVC.arrayNote = self.arrayKey
        viewVC.keyDataBase = "dbhealth"
        viewVC.idForItem = self.arrayId.max() ?? 0
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
    func initHeaderView() {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableview.frame.width, height: self.tableview.frame.height/5))
        headerView.backgroundColor = .red
        self.tableview.tableHeaderView = headerView
        
    }
    
//    func getDataCache() {
//        var arrayCache:[cachItem] = []
//        let realm = try! Realm()
//        let puppies = realm.objects(cachItem.self)
//        arrayCache = Array(puppies).reversed()
//        print("Puppies = \(arrayCache.count)")
//        for i in 0..<arrayCache.count {
//            let mm = arrayCache[i]
////            print("===== test \(item.title.base64Decoded())")
//
//            let post = ["id": mm.id,
//                        "content": mm.content.base64Decoded() ?? "",
//                        "title": mm.title.base64Decoded() ?? "",
//                        "urlimage": mm.urlImage.base64Decoded() ?? "",
//                        "urlweb": mm.urlWeb.base64Decoded() ?? "",
//                        "urlvideo": mm.urlVideo.base64Decoded() ?? ""] as [String : Any]
////            print("===== test \(post)")
//            print("=====key \(self.keyDataBase) noteName \(self.noteName1) title \(mm.title.base64Decoded())")
//            if mm.title.base64Decoded() != "" {
//             self.ref.child(self.keyDataBase).child(self.noteName1).child(mm.title.base64Decoded() ?? "NoName").setValue(post)
//            }
//
//
//        }
//    }
    
}

extension MMHeathyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrayGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MMHealthTableViewCell.className) as! MMHealthTableViewCell
        
        cell.arrayItem = self.arrayGroup[indexPath.section].arrayItem
        cell.nav = self.navigationController
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = MMHeaderViewForHealth()
        viewHeader.configCell(title: self.arrayGroup[section].title)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 232
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 68
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}

extension MMHeathyViewController {
    
    func getData() {
        
        self.ref.child("dbhealth").observe(.value) { (data) in
            // cho nay lay ra cac note chinh
            let realm = try! Realm()
            if let dicData:Dictionary<String,AnyObject> = data.value as? Dictionary<String,AnyObject> {
                self.arrayKey.removeAll()
                self.arrayGroup.removeAll()
                self.arrayId.removeAll()
                for i in dicData {
                    self.arrayKey.append(i.key)
                    let itemGroup = MMHealthGroup()
                    itemGroup.title = i.key
                    print("====Title \(i.key) =key")
                    self.ref.child("dbhealth").child(i.key).observe(.value, with: { (dataComplet) in
                        
                        var index:Int = 0
                        if let dicDataItem:Dictionary<String,AnyObject> = dataComplet.value as? Dictionary<String,AnyObject> {
                            for j in dicDataItem {
                                let item = MMHealthModel(object: j.value)
                                self.arrayId.append(item.id)
                                itemGroup.arrayItem.append(item)
                                print("====Title \(item.title)")
                                let itemcache = cachItem()
                                index = index + 1
                                itemcache.id = index
                                itemcache.title = item.title
                                itemcache.content = item.content
                                itemcache.urlImage = item.urlImage
                                itemcache.urlVideo = item.urlVideo
                                itemcache.urlWeb = item.urlWeb
                                try! realm.write {
//                                    realm.add(itemcache)
                                }
                                
                                
                            }
                        }
                        self.arrayGroup.append(itemGroup)
                        if self.arrayGroup.count == self.arrayKey.count {
                            for gr in self.arrayGroup {
                                for i in gr.arrayItem {
                                    print("====iii =\(i.urlImage)")
                                }
                            }
                            DispatchQueue.main.async {
                               self.tableview.reloadData()
                            }
                            
                        }
                        
                    })
                    
                }
            }
        }
        
    }
    
}


extension String {
    //: ### Base64 encoding a string
//    func base64Encoded() -> String? {
//        if let data = self.data(using: .utf8) {
//            return data.base64EncodedString()
//        }
//        return nil
//    }
    
    //: ### Base64 decoding a string
//    func base64Decoded() -> String? {
//        if let data = Data(base64Encoded: self) {
//            return String(data: data, encoding: .utf8)
//        }
//        return nil
//    }
}
