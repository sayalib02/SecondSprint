//
//  CartTableViewCell.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit

// start cartTableViewCell Class
class CartTableViewCell: UITableViewCell {

    //Outlet Start
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    //outlet end
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}// End of class


