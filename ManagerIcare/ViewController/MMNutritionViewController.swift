//
//  MMNutritionViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/23/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class MMNutritionViewController: MMBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayKey:[String] = []
    var arrayId:[Int] = []
    var arrayGroup:[MMHealthGroup] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let viewCell = UINib(nibName: MMHealthTableViewCell.className, bundle: nil)
        
        tableView.register( viewCell, forCellReuseIdentifier: MMHealthTableViewCell.className)
        tableView.separatorStyle = .none
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.sectionHeaderHeight = 0.0
        self.initHeaderView()
        
        self.navigationController?.title = "Dinh Dưỡng"
        
        if self.navigationController == nil {
            print("navigationController nil")
        } else {
            print("Navigation view controller not nil")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
    }
    
    @IBAction func actionAdData(_ sender: Any) {
        print("====== button right")
        let viewVC = MMAddHealthViewController()
        viewVC.edgesForExtendedLayout = []
        viewVC.arrayNote = self.arrayKey
        viewVC.idForItem = self.arrayId.max() ?? 0
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
    
    func initHeaderView() {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height/5))
        headerView.backgroundColor = .red
        self.tableView.tableHeaderView = headerView
                
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        self.clickMenu()
    }
}
extension MMNutritionViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension MMNutritionViewController {
    
    func getData() {
        
        self.ref.child("dbNutrition").observe(.value) { (data) in
            // cho nay lay ra cac note chinh
            if let dicData:Dictionary<String,AnyObject> = data.value as? Dictionary<String,AnyObject> {
                self.arrayKey.removeAll()
                self.arrayGroup.removeAll()
                self.arrayId.removeAll()
                for i in dicData {
                    self.arrayKey.append(i.key)
                    let itemGroup = MMHealthGroup()
                    itemGroup.title = i.key
                    print("====Title \(i.key) =key")
                    self.ref.child("dbNutrition").child(i.key).observe(.value, with: { (dataComplet) in
                        
                        
                        if let dicDataItem:Dictionary<String,AnyObject> = dataComplet.value as? Dictionary<String,AnyObject> {
                            for j in dicDataItem {
                                let item = MMHealthModel(object: j.value)
                                self.arrayId.append(item.id)
                                itemGroup.arrayItem.append(item)
                                print("====Title \(item.title)")
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
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    })
                    
                }
            }
        }
        
    }
    
}
