//
//  AirlineTableViewCell.swift
//  Airlines
//
//  Created by Amruth Kallyam on 5/2/25.
//

import UIKit

class AirlineTableViewCell: UITableViewCell {

    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
