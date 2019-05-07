//
//  TVCStocktakings.swift
//  MyStocktaking
//
//  Created by Jose Carlos Rodriguez on 4/30/19.
//  Copyright © 2019 kast. All rights reserved.
//

import UIKit

class TVCStocktakings: UITableViewCell {
    
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblMinimumAmount: UILabel!
    @IBOutlet weak var lblWarehouse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
