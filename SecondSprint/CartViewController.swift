//
//  CartViewController.swift
//  SecondSprint
//
//  Created by Capgemini-DA071 on 9/26/22.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

// start CartViewController class
class CartViewController: UIViewController {

    //CoreData
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //Outlet start
    @IBOutlet weak var yourCartTable: UITableView!
    @IBOutlet weak var placeOrder: UIButton!
    
    // Declare items
    var details = [Item1]()
    let userEmail = Auth.auth().currentUser?.email
    
    //Testing part
    static func getVC() -> CartViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchDetails()
        
        let emailP = NSPredicate(format: "emailID MATCHES %@", userEmail as! String)

        // Do any additional setup afterloading the view.
        let detailsFetch = NSFetchRequest<NSManagedObject>(entityName: "Item1")
        detailsFetch.predicate = emailP
        do{
            details = try context?.fetch(detailsFetch) as! [Item1]
        }

        catch{
            print("Cannot get data")
        }
        
        DispatchQueue.main.async {
            self.yourCartTable.reloadData()
        }
    
    }

    
    
        
    
}// end of class

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //DispatchQueue.main.async{
            
        //}
        
        let cell1 = yourCartTable.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! YourCartTableViewCell
        let eID = self.details[indexPath.row].emailID
        cell1.selectedTitle.text = self.details[indexPath.row].title
        cell1.selectedDescription.text = self.details[indexPath.row].describe
        
        return cell1
        
    }
    
    
}
