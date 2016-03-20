//
//  DashboardTableViewController.swift
//  HealthifyMeDashboard
//
//  Created by Dhwani Thaker on 3/18/16.
//  Copyright © 2016 Dhwani Thaker. All rights reserved.
//

import UIKit

class DashboardTableViewController: UITableViewController, CaloriesEatenTableViewCellDelegate{
    
    var cellTapped : Bool = true
    var currentRow = 0
    
    var storyBoard : UIStoryboard!
    
    var expandedIndexPaths: [NSIndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "CaloriesEatenTableViewCell", bundle: nil), forCellReuseIdentifier: "calEatenCell")
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("calEatenCell", forIndexPath: indexPath) as! CaloriesEatenTableViewCell
        
        if cell.caloriesEatenTableViewCellDelegate == nil
        {
            cell.caloriesEatenTableViewCellDelegate = self
        }
        
        if indexPath.row == 0
        {
            cell.backgroundColor = UIColor(red: 251/255, green: 106/255, blue: 7/255, alpha: 1.0)
        }
        
        else if indexPath.row == 1
        {
            cell.backgroundColor = UIColor(red: 39/255, green: 130/255, blue: 191/255, alpha: 1.0)

        }
        else
        {
            cell.backgroundColor = UIColor(red: 83/255, green: 26/255, blue: 171/255, alpha: 1.0)

        }
        
        return cell
    }
    
    func cellTapped(cell : CaloriesEatenTableViewCell)
    {
        let indexPath = self.tableView.indexPathForCell(cell)
        if expandedIndexPaths.contains(indexPath!)
        {
            cell.expandedButtonOutlet.isClicked = false
            expandedIndexPaths.removeAtIndex(expandedIndexPaths.indexOf(indexPath!)!)

        }
        else
        {
            cell.expandedButtonOutlet.isClicked = true
            
            expandedIndexPaths.append(indexPath!)

        }
        self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return expandedIndexPaths.contains(indexPath) ? 210 : 50
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
