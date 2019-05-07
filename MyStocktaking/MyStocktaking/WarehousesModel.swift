//
//  WarehousesModel.swift
//  MyStocktaking
//
//  Created by Jose Carlos Rodriguez on 4/30/19.
//  Copyright © 2019 kast. All rights reserved.
//

class WarehousesModel{
    var id: String?
    var name: String?
    var location: String?
    var telephone: String?
    
    init(id: String?, name: String?, location: String?, telephone: String?) {
        self.id = id
        self.name = name
        self.location = location
        self.telephone = telephone
    }
}
