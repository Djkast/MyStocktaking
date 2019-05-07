//
//  StocktakingModel.swift
//  MyStocktaking
//
//  Created by Jose Carlos Rodriguez on 4/30/19.
//  Copyright © 2019 kast. All rights reserved.
//

class StocktakingModel{
    var id: String?
    var product: String?
    var price: String?
    var quantity: String?
    var minimumAmount: String?
    var warehouse: String?
    
    init(id: String?, product: String?, price: String?, quantity: String?, minimumAmount: String?, warehouse: String?) {
        self.id = id
        self.product = product
        self.price = price
        self.quantity = quantity
        self.minimumAmount = minimumAmount
        self.warehouse = warehouse
    }
}
