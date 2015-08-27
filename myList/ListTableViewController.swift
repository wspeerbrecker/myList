//
//  ListTableViewController.swift
//  myList
//
//  Created by Admin on 2015-08-12.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {

    var myList : [List] = []
    var selectedItem : List? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override func viewDidAppear(animated: Bool) {
        
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "List")
        
        var results = context.executeFetchRequest(freq, error: nil)
        if results != nil
        {
            myList = results! as! [List]
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as! UITableViewCell
        
        if let ip = indexPath as NSIndexPath?
        {
            var data: List = myList[ip.row]
            cell.textLabel?.text = data.item
            cell.detailTextLabel!.text = "\(data.quantity) items - \(data.info)"
        }
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedItem = myList[indexPath.row]
        println("didSelectRowAtIndexPath \(myList[indexPath.row])")
        self.performSegueWithIdentifier("Update", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Update"
        {
            var itemViewController = segue.destinationViewController as! ItemViewController
            itemViewController.existingItem = selectedItem
            
            println("Update Segue \(selectedItem)")
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            if let tv = tableView as UITableView?
            {
                context.deleteObject(myList[indexPath.row])
                myList.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
            }
            var error: NSError? = nil
            if !context.save(&error)
            {
                abort()
            }
        }
    }

}
