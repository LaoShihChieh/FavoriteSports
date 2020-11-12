//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2020/10/22.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Baseball", "Basketball", "Football", "Other"]
    
    var restaurantImages = ["baseball", "basketball", "football", "other"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var restaurantIsVisited = Array(repeating: false, count: 21)
    var like = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row] //optioinal chaining
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        
        if restaurantIsVisited[indexPath.row] {
        cell.accessoryType = .checkmark
            
        } else {
        cell.accessoryType = .none

        }

        //cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        /*if restaurantIsVisited[indexPath.row] {
like.append(restaurantNames[indexPath.row])}
        let joined = like.joined(separator: ", ")
        cell.likeLabel.text = "  I like: " + joined
         if let indexValue = like.firstIndex(of: restaurantNames[indexPath.row]) {
             like.remove(at: indexValue)
         }
*/
         
        return cell
    }
    

    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }

        // Add Call action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // Check-in action
        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurantIsVisited[indexPath.row] = true
        })
        optionMenu.addAction(checkInAction)

        //add undo check-in action
        let uncheckInAction = UIAlertAction(title: "Undo Check in", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            if self.restaurantIsVisited[indexPath.row] {  //if ckecked
                cell?.accessoryType = .none
                self.restaurantIsVisited[indexPath.row] = false
            }
        })
        optionMenu.addAction(uncheckInAction)
        
        
        
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        // Deselect a row
        tableView.deselectRow(at: indexPath, animated: false)
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurantImageName = restaurantImages[indexPath.row] + "_photo"
            }
        }
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        /*let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            // Delete the row from the data source
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Call completion handler with true to indicate
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]

            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        // Set the icon and background color for the actions
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(systemName: "trash")
        
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(systemName: "square.and.arrow.up")*/
        
        let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
                       
           let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
           self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? true : true
           cell.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
           
           completionHandler(true)
            if self.restaurantIsVisited[indexPath.row] {
            self.like.append(self.restaurantNames[indexPath.row])
            let joined = self.like.joined(separator: ", ")
            cell.likeLabel.text = "  I like: \(joined)"
            }else{
                if let indexValue = self.like.firstIndex(of: self.restaurantNames[indexPath.row]) {
                    self.like.remove(at: indexValue)
                }
                let joined = self.like.joined(separator: ", ")
                cell.likeLabel.text = "  I like: \(joined)"
            }
            
           }
                   
           let checkInIcon = restaurantIsVisited[indexPath.row] ? "checkmark" : "checkmark"
           checkInAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
           checkInAction.image = UIImage(systemName: checkInIcon)
                   
           let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])

        return swipeConfiguration
    }
    

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
   let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
               
   let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
   self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : false
   cell.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
   completionHandler(true)
    if self.restaurantIsVisited[indexPath.row] {
    self.like.append(self.restaurantNames[indexPath.row])
    let joined = self.like.joined(separator: ", ")
    cell.likeLabel.text = "  I like: \(joined)"
    }else{
        if let indexValue = self.like.firstIndex(of: self.restaurantNames[indexPath.row]) {
            self.like.remove(at: indexValue)
        }
        let joined = self.like.joined(separator: ", ")
        cell.likeLabel.text = "  I like: \(joined)"
    }
   }
           
   let checkInIcon = restaurantIsVisited[indexPath.row] ? "arrow.uturn.left" : "arrow.uturn.left"
   checkInAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
   checkInAction.image = UIImage(systemName: checkInIcon)
           
   let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
          
            
    return swipeConfiguration
    }
    
    

}
