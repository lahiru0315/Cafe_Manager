//
//  ProductTableViewCell.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/30/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FoodDescription: UILabel!
    
  
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var Offer: UILabel!
    
    @IBOutlet weak var sell: UISwitch!
    var didValueChanged : ((Bool)->Void)!
    override func awakeFromNib() {
        super.awakeFromNib()
        sell.addTarget(self, action: #selector(onSellValueChanged(sender:)), for: .valueChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func onSellValueChanged(sender:UISwitch){
        didValueChanged(sender.isOn)
    }

}
