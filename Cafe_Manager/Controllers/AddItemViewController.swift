//
//  AddItemViewController.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/28/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
class CellClass: UITableViewCell {
    
}

class AddItemViewController: UIViewController {

     @IBOutlet weak var itemName: UITextField!
        @IBOutlet weak var descriptions: UITextField!
        @IBOutlet weak var price: UITextField!
        @IBOutlet weak var discount: UITextField!
        @IBOutlet weak var isSell: UIButton!
        @IBOutlet weak var myImage: UIImageView!
        @IBOutlet weak var image: UIButton!
        @IBOutlet weak var categoryList: UIButton!
        let transparentView = UIView()
        let tableView = UITableView()
        var selectedButton = UIButton()
        var sell=0
        var dataSource :[Category] = []
        var ref: DatabaseReference!
        var storageRef = Storage.storage()
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(CellClass.self, forCellReuseIdentifier: "categoryCell")
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
                                              
                                              self.dataSource.append(cate)
                          
                       }
    //                                   self.categoryTable.reloadData()
                           //            print(self.foods[0].id)
                                   })
            // Do any additional setup after loading the view.
        }
        
        @IBAction func imageUploader(_ sender: Any) {
           let picker = UIImagePickerController()
             picker.sourceType = .photoLibrary
             picker.delegate = self
             picker.allowsEditing = true
            present(picker, animated: true)

        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
              picker.dismiss(animated: true, completion: nil)
              
              guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
                  return
              }
              guard let imagedata = image.pngData() else {
                  return
              }
           
              
                  
              self.myImage.image = UIImage(data: imagedata)
            
              
              
              
                      
                  
              }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        @IBAction func onCheck(_ sender: UIButton) {
            if sender.isSelected{
                sender.isSelected = false
                sell=0
            }
            else
            {
                sender.isSelected = true
                sell=1
            }
        }
        @IBAction func btnSave(_ sender: UIButton) {
            let ref = Database.database().reference()
                    let key = ref.child("Item").childByAutoId().key!
                   let name=itemName.text!
            let des=descriptions.text!
            let pri=Float(price.text!)
            let dis=Int(discount.text!)
            let cat=categoryList.titleLabel!.text
            
            let storage = Storage.storage().reference()
            
    //        let path:String = "foodimages/" + ref2.documentID + ".png"
            
            storage.child("FoodImage").putData((self.myImage.image?.pngData())!, metadata: nil) { (_, Error) in
                if Error != nil
                {
                    print("erro")
                }
                else
                {
                    
                    
                }
            }
            
                                          ref.child("Item/"+key).setValue(["id":key,
                                                                           "Name":name,"Description":des,"Price":pri,"image":"test.jpg","Discount":dis,"Category":cat,"isSell":sell])
        }
        func addTransparentView(frames: CGRect) {
            let window = UIApplication.shared.keyWindow
            transparentView.frame = window?.frame ?? self.view.frame
            self.view.addSubview(transparentView)
            
            tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            self.view.addSubview(tableView)
            tableView.layer.cornerRadius = 5
            
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            tableView.reloadData()
           let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            transparentView.addGestureRecognizer(tapgesture)
            transparentView.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0.5
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 200)
            }, completion: nil)
        }
        @objc func removeTransparentView() {
            let frames = selectedButton.frame
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            }, completion: nil)
        }

        @IBAction func onSelectCategory(_ sender: Any) {
    //        dataSource = ["Apple", "Mango", "Orange"]
            selectedButton = categoryList
            addTransparentView(frames: categoryList.frame)
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return self.dataSource.count
           }
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 100
           }
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell",for: indexPath)
            cell.textLabel?.text = self.dataSource[indexPath.row].category
            //              let storage = Storage.storage()
            //              let storageRef = storage.reference()
                          
            //              let path = self.categories[indexPath.row].photoURL
                          
                         
                //        cell.FoodItemImage.image = UIImage(named: foodItems[2])

            //            cell.lblFoofDescription.text = self.foods[indexPath.row].discription
            //            cell.lblPrice.text = ( "Rs." + String(self.foods[indexPath.row].price))

                        return cell
           }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedButton.setTitle(dataSource[indexPath.row].category, for: .normal)
            removeTransparentView()
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
    extension addItemViewController:UIImagePickerControllerDelegate & UINavigationControllerDelegate{
        func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
            let selectedImage : UIImage = image
            // 1 Media Data in memory
            let data = Data()

            // 2 Create a reference to the file you want to upload
            let riversRef = storageRef.reference(withPath: "items/")

            // 3 Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
              if let error = error {
                // 4 Uh-oh, an error occurred!
                return
              }

              // 5
    //          reference.downloadURL(completion: { (url, error) in
    //            if let error = error { return }
    //            // 6
    //          })
            }
        }

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

