//
//  PreviewProductViewController.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/28/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class PreviewProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
     var foods :[Item] = []
    var category :[Category] = []
    var headerTitles:[String] = ["csdcs","sdasds"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        foods.removeAll()
        ref = Database.database().reference()
        let allPlaces = self.ref.child("Item")
                allPlaces.observe(.value, with: { snapshot in
                    for child in snapshot.children {
                        let snap = child as! DataSnapshot
                        let placeDict = snap.value as! [String: Any]
                        let discount = placeDict["Discount"] as! Float
                        let discription = placeDict["Description"] as! String
                        let foodName = placeDict["Name"] as! String
                        let cate = placeDict["Category"] as! String
                        let id = placeDict["id"] as! String
                        let photoURL = placeDict["image"] as! String
                        let price = placeDict["Price"] as! Float
                        let sell=placeDict["isSell"]as! Int
                         self.headerTitles.append(cate)
                        let food = Cafe_Manager.Item(Name:foodName,discription: discription,price: price,discount: discount,id:id,photourl: photoURL,sell:sell,category: cate )
                                           
                                           self.foods.append(food)
                       
                       
                    }
                    self.tableView.reloadData()
        //            print(self.foods[0].id)
                })

print(self.category)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EnableFun(_ sender: UISwitch) {
        if(sender.isOn)
        {
             let alert = UIAlertController(title: "Authentication Error", message: " invalid Email or Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
               let ref2=Database.database().reference();
               let allCategory = ref2.child("Category").queryOrdered(byChild: "isDelete").queryEqual(toValue: "0")
                     allCategory.observe(.value, with: { snapshot in
                     for child in snapshot.children {
                         let snap = child as! DataSnapshot
                         let placeDict = snap.value as! [String: Any]
                         let categoryName = placeDict["category"] as! String
                         let id = placeDict["id"] as! String
                         let delete=placeDict["isDelete"] as! String
                        
                         
                         let categi = Cafe_Manager.Category(category: categoryName, id: id, isDelete: delete)
                                            
                                            self.category.append(categi)
                        
                     }
       //                              self.categoryTable.reloadData()
                         //            print(self.foods[0].id)
                     });        return headerTitles[section]
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        print(self.category.count)
           return 1
    }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.foods.count
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.foods[section].category.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! ProductTableViewCell
            

            cell.FoodName.text = self.foods[indexPath.row].foodName
            cell.didValueChanged = {
                
                value in
                self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    self.ref.child("Item").child(self.foods[indexPath.row].id).child("isSell").setValue(value ? 1 : 0)
                   })
                self.foods.removeAll()
                
//                self.foods[indexPath.row].id
            }
              let storage = Storage.storage()
            _ = storage.reference()
//            storageRef.child("").get
//              let path = self.foods[indexPath.row].photoURL
//
//
//              let formattedString = path.replacingOccurrences(of: " ", with: "")
//              let islandRef = storageRef.child(formattedString)
//
//              islandRef.getData(maxSize: 1 * 250 * 250) { data, error in
//                  if error != nil {
//                 print("error")
//                } else {
//                  // Data for "images/island.jpg" is returned
//                  let image = UIImage(data: data!)
//                  cell.FoodItemImage.image = image
//
//
//                }
//              }
    //        cell.FoodItemImage.image = UIImage(named: foodItems[2])

            cell.FoodDescription.text = self.foods[indexPath.row].discription
            cell.Offer.text = ( "" + String(self.foods[indexPath.row].discount))
            cell.Price.text = ( "Rs." + String(self.foods[indexPath.row].price))
            if(self.foods[indexPath.row].sell==1)
            {
                cell.sell.setOn(true, animated: true)
            }
            else{
                cell.sell.setOn(false, animated: true)
            }
            return cell
            
           
        }
    
//let headerTitles = ["Some Data 1", "KickAss"]
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
