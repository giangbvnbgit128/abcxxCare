//
//  NationalVaccinationViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/31/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class NationalVaccinationViewController: UIViewController {

    @IBOutlet weak var nscontraintTopView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let viewCell = UINib(nibName: MMVaccinationalTableViewCell.className, bundle: nil)
        
        tableView.register( viewCell, forCellReuseIdentifier: MMVaccinationalTableViewCell.className)
        self.tableView.estimatedRowHeight = 50
        self.tableView.separatorStyle = .none
        
        self.nscontraintTopView.constant = 64
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}

extension NationalVaccinationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MMVaccinationalTableViewCell.className) as! MMVaccinationalTableViewCell
        let mode = MMVaccinationalModel()
        mode.id = 1
        mode.description = "Dưới đây là lịch tiêm chủng quốc gia trong chương trình tiêm chủng mở rộng hiện nay đang áp dụng tại Việt Nam. Cha mẹ cần phải ghi nhớ và để bảo vệ sức khỏe của bé và cộng đồng."
        mode.title = "Vac xin viem gan B"
        cell.configCell(number: indexPath.row, vaccitional: mode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
