//
//  VCWarehouses.swift
//  MyStocktaking
//
//  Created by Jose Carlos Rodriguez on 4/30/19.
//  Copyright © 2019 kast. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VCWarehouses: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refWarehouses: DatabaseReference!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    
    
    @IBOutlet weak var tblWarehouses: UITableView!
    
    var warehousesList = [WarehousesModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let warehouse = warehousesList[indexPath.row]
        let alertController = UIAlertController(title: warehouse.name, message: "Give new values to update warehouse", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let id = warehouse.id
            let name = alertController.textFields?[0].text
            let location = alertController.textFields?[1].text
            let telephone = alertController.textFields?[2].text
            
            self.updateStocktaking(id: id!,
                                   name: name!,
                                   location: location!,
                                   telephone: telephone!)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteStocktaking(id: warehouse.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = warehouse.name
        }
        alertController.addTextField{(textField) in
            textField.text = warehouse.location
        }
        alertController.addTextField{(textField) in
            textField.text = warehouse.telephone
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateStocktaking(id: String, name: String, location: String, telephone: String){
        let stocktaking = [
            "id": id,
            "Name": name,
            "Location": location,
            "Telephone": telephone
        ]
        refWarehouses.child(id).setValue(stocktaking)
        
        clean()
    }
    
    func deleteStocktaking(id: String){
        refWarehouses.child(id).setValue(nil)
        //tblStocktaking.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warehousesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellWarehuoses", for: indexPath) as! TVCWarehouses
        
        let warehouses: WarehousesModel
        
        warehouses = warehousesList[indexPath.row]
        
        cell.lblName.text = warehouses.name
        cell.lblLocation.text = warehouses.location
        cell.lblTelephone.text = warehouses.telephone
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refWarehouses = Database.database().reference().child("warehouses")
        
        refWarehouses.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.warehousesList.removeAll()
                for warehouses in snapshot.children.allObjects as![DataSnapshot]{
                    let warehousesObject = warehouses.value as? [String: AnyObject]
                    let warehouseName = warehousesObject?["Name"]
                    let warehouseLocation = warehousesObject?["Location"]
                    let warehouseTelephone = warehousesObject?["Telephone"]
                    let warehouseId = warehousesObject?["id"]
                    
                    let warehouse = WarehousesModel(id: warehouseId as! String?, name: warehouseName as! String?, location: warehouseLocation as! String?, telephone: warehouseTelephone as! String?)
                    
                    self.warehousesList.append(warehouse)
                }
                self.tblWarehouses.reloadData()
            }
        })
    }
    
    func addWarehouse() {
        let key = refWarehouses.childByAutoId().key
        let stocktaking = ["id":key,
                           "Name":txtName.text! as String,
                           "Location":txtLocation.text! as String,
                           "Telephone":txtTelephone.text! as String]
        refWarehouses.child(key!).setValue(stocktaking)
        
        clean()
    }
    
    func clean(){
        txtName.text! = ""
        txtLocation.text! = ""
        txtTelephone.text! = ""
    }
    
    @IBAction func btnAddWarehouse(_ sender: UIButton) {
        addWarehouse()
    }
    

}
