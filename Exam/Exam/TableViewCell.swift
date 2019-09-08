//
//  TableViewCell.swift
//  Exam
//
//  Created by Dominic on 08/09/2019.
//  Copyright © 2019 Dominic. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var lblCode: UILabel!
    @IBOutlet var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
