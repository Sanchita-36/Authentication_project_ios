//
//  BatchesTableViewController.swift
//  Authentication
//
//  Created by Mac on 05/01/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class BatchesTableViewController: UIViewController {

    @IBOutlet weak var batchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension BatchesTableViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let batchCell = tableView.dequeueReusableCell(withIdentifier: "batchCell")
        batchCell?.textLabel!.text = "iOS"
        return batchCell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
