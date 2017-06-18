//
//  MenuTableViewController.swift
//  ARKitExamples
//
//  Created by Mohammad Azam on 6/16/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewController : UITableViewController {
    
    let menuItems = ["Simple Box", "Simple Box with Touch", "Bar Charts", "Red Carpet Using Plane Detection", "Planets"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuItemIndex = indexPath.row
        
        switch menuItemIndex {
            case 0:
                let controller = SimpleBoxViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            
            case 1:
                let controller = SimpleBoxWithTouchViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            
            case 2:
                let controller = GraphViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            
            case 3:
                let controller = RedCarpetViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            
            case 4:
                let controller = PlanetsViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            
            default:
                print("something")
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.menuItems[indexPath.row]
        return cell
    }
    
}

