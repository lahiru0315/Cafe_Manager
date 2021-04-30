//
//  StoreViewController.swift
//  Cafe_Manager
//
//  Created by Lahiru on 4/17/21.
//  Copyright © 2021 Lahiru. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var MainView: UIView!
    @IBOutlet var vireContainer: UIView!
    var simpleview1:UIView!
    var simpleview2:UIView!
    var simpleview3:UIView!
    

    @IBOutlet weak var AddItemView: UIView!
    
    @IBOutlet weak var AddCategoryView: UIView!
    
    @IBOutlet weak var PreviewProductView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        simpleview1 = PreviewViewController().view
//        simpleview2 = CategoryViewController().view
//        simpleview3 = MenuViewController().view
//        MainView.self.addSubview(simpleview3)
//        MainView.self.addSubview(simpleview2)
//        MainView.self.addSubview(simpleview1)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func topTabBarButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            AddItemView.alpha=0
            AddCategoryView.alpha=0
            PreviewProductView.alpha=1
            break
        case 1:
            AddItemView.alpha=0
            AddCategoryView.alpha=1
            PreviewProductView.alpha=0
            break
        case 2:
            AddItemView.alpha=1
            AddCategoryView.alpha=0
            PreviewProductView.alpha=0
            break
        default:
            break
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
