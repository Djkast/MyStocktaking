//
//  ViewController.swift
//  MyStocktaking
//
//  Created by LABMAC07 on 05/04/19.
//  Copyright © 2019 kast. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refStocktakings: DatabaseReference!

    @IBOutlet weak var txtProduct: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtMinimumAmount: UITextField!
    @IBOutlet weak var txtWarehuose: UITextField!
    
    @IBOutlet weak var tblStocktaking: UITableView!
    
    var stocktakingsList = [StocktakingModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stocktaking = stocktakingsList[indexPath.row]
        let alertController = UIAlertController(title: stocktaking.product, message: "Give new values to update stocktaking", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let id = stocktaking.id
            let product = alertController.textFields?[0].text
            let price = alertController.textFields?[1].text
            let quantity = alertController.textFields?[2].text
            let minimumAmount = alertController.textFields?[3].text
            let warehuose = alertController.textFields?[4].text
            
            self.updateStocktaking(id: id!,
                              product: product!,
                              price: price!,
                              quantity: quantity!,
                              minimumAmount: minimumAmount!,
                              warehuose: warehuose!)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteStocktaking(id: stocktaking.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = stocktaking.product
        }
        alertController.addTextField{(textField) in
            textField.text = stocktaking.price
        }
        alertController.addTextField{(textField) in
            textField.text = stocktaking.quantity
        }
        alertController.addTextField{(textField) in
            textField.text = stocktaking.minimumAmount
        }
        alertController.addTextField{(textField) in
            textField.text = stocktaking.warehouse
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateStocktaking(id: String, product: String, price: String, quantity: String, minimumAmount: String, warehuose: String){
        let stocktaking = [
            "id": id,
            "Product": product,
            "Price": price,
            "Quantity": quantity,
            "MinimumAmount": minimumAmount,
            "Warehuose": warehuose
        ]
        refStocktakings.child(id).setValue(stocktaking)
        
        clean()
    }
    
    func deleteStocktaking(id: String){
        refStocktakings.child(id).setValue(nil)
        //tblStocktaking.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocktakingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellStocktaking", for: indexPath) as! TVCStocktakings
        
        let stocktaking: StocktakingModel
        
        stocktaking = stocktakingsList[indexPath.row]
        
        cell.lblProduct.text = stocktaking.product
        cell.lblPrice.text = stocktaking.price
        cell.lblQuantity.text = stocktaking.quantity
        cell.lblMinimumAmount.text = stocktaking.minimumAmount
        cell.lblWarehouse.text = stocktaking.warehouse
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refStocktakings = Database.database().reference().child("stocktakings")
        
        refStocktakings.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.stocktakingsList.removeAll()
                for stocktakings in snapshot.children.allObjects as![DataSnapshot]{
                    let stocktakingsObject = stocktakings.value as? [String: AnyObject]
                    let stocktakingProduct = stocktakingsObject?["Product"]
                    let stocktakingPrice = stocktakingsObject?["Price"]
                    let stocktakingQuantity = stocktakingsObject?["Quantity"]
                    let stocktakingMinimumAmount = stocktakingsObject?["MinimumAmount"]
                    let stocktakingWarehuose = stocktakingsObject?["Warehuose"]
                    let stocktakingId = stocktakingsObject?["id"]
                    
                    let stocktaking = StocktakingModel(id: stocktakingId as! String?, product: stocktakingProduct as! String?, price: stocktakingPrice as! String?, quantity: stocktakingQuantity as! String?, minimumAmount: stocktakingMinimumAmount as! String?, warehouse: stocktakingWarehuose as! String?)
                    
                    self.stocktakingsList.append(stocktaking)
                }
                self.tblStocktaking.reloadData()
            }
        })
    }

    func addStocktaking() {
        let key = refStocktakings.childByAutoId().key
        let stocktaking = ["id":key,
                      "Product":txtProduct.text! as String,
                      "Price":txtPrice.text! as String,
                      "Quantity":txtQuantity.text! as String,
                      "MinimumAmount":txtMinimumAmount.text! as String,
                      "Warehuose":txtWarehuose.text! as String]
        refStocktakings.child(key!).setValue(stocktaking)
        
        clean()
    }
    
    func clean(){
        txtProduct.text! = ""
        txtPrice.text! = ""
        txtQuantity.text! = ""
        txtMinimumAmount.text! = ""
        txtWarehuose.text! = ""
    }
    
    @IBAction func btnAddStocktaking(_ sender: UIButton) {
        addStocktaking()
    }
    

}

