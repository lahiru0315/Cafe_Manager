//
//  CategoryViewController.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/17/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryName: UITextField!
        var categories :[Category] = []
        var ref: DatabaseReference!
        override func viewDidLoad() {
            super.viewDidLoad()
            categoryTableView.delegate = self
            categoryTableView.dataSource = self
            ref = Database.database().reference()
            
            let allPlaces = self.ref.child("Category").queryOrdered(byChild: "isDelete").queryEqual(toValue: "0")
            allPlaces.observe(.value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let placeDict = snap.value as! [String: Any]
                let categoryName = placeDict["category"] as! String
                let id = placeDict["id"] as! String
                let delete=placeDict["isDelete"] as! String
               
                
                let cate = Cafe_Manager.Category(category: categoryName, id: id, isDelete: delete)
                                   
                                   self.categories.append(cate)
               
            }
                            self.categoryTableView.reloadData()
                //            print(self.foods[0].id)
                        })
            // Do any additional setup after loading the view.
        }
        
        @IBAction func addCategory(_ sender: UIButton) {
            let ref = Database.database().reference()
             let key = ref.child("Category").childByAutoId().key!
            let category=categoryName.text!
                                   ref.child("Category/"+key).setValue(["id":key,
                                                                        "category":category,"isDelete":"0"])
            self.categories.removeAll()
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.categories.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
                let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
                

            cell.CaregoryLable.text = self.categories[indexPath.row].category
    //              let storage = Storage.storage()
    //              let storageRef = storage.reference()
                  
    //              let path = self.categories[indexPath.row].photoURL
                  
                 
        //        cell.FoodItemImage.image = UIImage(named: foodItems[2])

    //            cell.lblFoofDescription.text = self.foods[indexPath.row].discription
    //            cell.lblPrice.text = ( "Rs." + String(self.foods[indexPath.row].price))

                return cell
                
               
            }
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
               return UISwipeActionsConfiguration(actions: [
                   makeDeleteContextualAction(forRowAt: indexPath)
               ])
           }
        private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
            return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
                let path = self.categories[indexPath.row].id
                self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                       self.ref.child("Category").child(path).child("isDelete").setValue("1")
                   })
                self.categories.removeAll()
                completion(true)
            }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
