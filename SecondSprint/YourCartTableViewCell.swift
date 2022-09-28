//
//  YourCartTableViewCell.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/27/22.
//

import UIKit

class YourCartTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var selectedTitle: UILabel!
    
    @IBOutlet weak var selectedDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
