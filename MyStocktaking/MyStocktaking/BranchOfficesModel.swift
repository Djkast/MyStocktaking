//
//  BranchOfficesModel.swift
//  MyStocktaking
//
//  Created by Jose Carlos Rodriguez on 4/30/19.
//  Copyright © 2019 kast. All rights reserved.
//

class BranchOfficesModel{
    var id: String?
    var name: String?
    var city: String?
    var region: String?
    var telephone: String?
    
    init(id: String?, name: String?, city: String?, region: String?, telephone: String?) {
        self.id = id
        self.name = name
        self.city = city
        self.region = region
        self.telephone = telephone
    }
}
