//
//  BatchTableViewCell.swift
//  Authentication
//
//  Created by Mac on 12/02/21.
//  Copyright © 2021 Sanchita. All rights reserved.
//

import UIKit

class BatchTableViewCell: UITableViewCell {

    @IBOutlet weak var batchNameLB: UILabel!
    @IBOutlet weak var batchDateLB: UILabel!
    @IBOutlet weak var batchFromTimeLB: UILabel!
    @IBOutlet weak var batchToTimeLB: UILabel!
    @IBOutlet weak var batchAttendanceLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
