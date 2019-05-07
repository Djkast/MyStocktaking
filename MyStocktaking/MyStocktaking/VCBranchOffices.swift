//
//  VCBranchOffices.swift
//  MyStocktaking
//
//  Created by Jose Carlos Rodriguez on 4/30/19.
//  Copyright © 2019 kast. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VCBranchOffices: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refBranchOfficess: DatabaseReference!

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtRegion: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    
    @IBOutlet weak var tblBranchOffice: UITableView!
    
    var branchOfficesList = [BranchOfficesModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let branchoffice = branchOfficesList[indexPath.row]
        let alertController = UIAlertController(title: branchoffice.name, message: "Give new values to update branch office", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let id = branchoffice.id
            let name = alertController.textFields?[0].text
            let city = alertController.textFields?[1].text
            let region = alertController.textFields?[2].text
            let telephone = alertController.textFields?[3].text
            
            self.updateStocktaking(id: id!,
                                   name: name!,
                                   city: city!,
                                   region: region!,
                                   telephone: telephone!)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteStocktaking(id: branchoffice.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = branchoffice.name
        }
        alertController.addTextField{(textField) in
            textField.text = branchoffice.city
        }
        alertController.addTextField{(textField) in
            textField.text = branchoffice.region
        }
        alertController.addTextField{(textField) in
            textField.text = branchoffice.telephone
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateStocktaking(id: String, name: String, city: String, region: String, telephone: String){
        let branchOffice = [
            "id": id,
            "Name": name,
            "City": city,
            "Region": region,
            "Telephone": telephone
        ]
        refBranchOfficess.child(id).setValue(branchOffice)
        
        clean()
    }
    
    func deleteStocktaking(id: String){
        refBranchOfficess.child(id).setValue(nil)
        //tblStocktaking.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchOfficesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBranchOffices", for: indexPath) as! TVCBranchOffices
        
        let branchOffice: BranchOfficesModel
        
        branchOffice = branchOfficesList[indexPath.row]
        
        cell.lblName.text = branchOffice.name
        cell.lblCity.text = branchOffice.city
        cell.lblRegion.text = branchOffice.region
        cell.lblTelephone.text = branchOffice.telephone
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        refBranchOfficess = Database.database().reference().child("branchOffices")
        
        refBranchOfficess.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.branchOfficesList.removeAll()
                for branchOffices in snapshot.children.allObjects as![DataSnapshot]{
                    let branchOfficesObject = branchOffices.value as? [String: AnyObject]
                    let branchOfficeName = branchOfficesObject?["Name"]
                    let branchOfficeCity = branchOfficesObject?["City"]
                    let branchOfficeRegion = branchOfficesObject?["Region"]
                    let branchOfficeTelephone = branchOfficesObject?["Telephone"]
                    let branchOfficeId = branchOfficesObject?["id"]
                    
                    let branchOffice = BranchOfficesModel(id: branchOfficeId as! String?, name: branchOfficeName as! String?, city: branchOfficeCity as! String?, region: branchOfficeRegion as! String?, telephone: branchOfficeTelephone as! String?)
                    
                    self.branchOfficesList.append(branchOffice)
                }
                self.tblBranchOffice.reloadData()
            }
        })
    }
    
    func addBranchOffice() {
        let key = refBranchOfficess.childByAutoId().key
        let branchOffice = ["id":key,
                           "Name":txtName.text! as String,
                           "City":txtCity.text! as String,
                           "Region":txtRegion.text! as String,
                           "Telephone":txtTelephone.text! as String]
        refBranchOfficess.child(key!).setValue(branchOffice)
        
        clean()
    }
    
    func clean(){
        txtName.text! = ""
        txtCity.text! = ""
        txtRegion.text! = ""
        txtTelephone.text! = ""
    }
    
    @IBAction func btnAddBranchOffice(_ sender: UIButton) {
        addBranchOffice()
    }

}
