//
//  ItemViewController.swift
//  myList
//
//  Created by Admin on 2015-08-12.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {

    @IBOutlet weak var textFieldItem: UITextField!
    @IBOutlet weak var textFieldQuantity: UITextField!
    @IBOutlet weak var textFieldInfo: UITextField!

    var existingItem : List? = nil
    var existingItemIndexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if existingItem != nil
        {
            textFieldItem.text = existingItem?.item
            textFieldQuantity.text = existingItem?.quantity
            textFieldInfo.text = existingItem?.info
            
            println(existingItem)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func saveTapped(sender: AnyObject) {
        
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Reference moc
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: context)

        if existingItem != nil
        {
            
            existingItem?.item = textFieldItem.text
            existingItem?.quantity = textFieldQuantity.text
            existingItem?.info = textFieldInfo.text
            
            let freq = NSFetchRequest(entityName: "List")
            
            var results = context.executeFetchRequest(freq, error: nil)
            if results != nil
            {
                var myList : [List] = results! as! [List]
                if let idx = existingItemIndexPath?.row
                {
                myList[idx] = existingItem!
                results = myList
                }
            }
        }
        else
        {
            // Create instance of our data model and initilize
            var newItem = NSEntityDescription.insertNewObjectForEntityForName("List", inManagedObjectContext: context) as! List
            // Map our properties
            newItem.item = textFieldItem.text
            newItem.quantity = textFieldQuantity.text
            newItem.info = textFieldInfo.text
        }
        // Save our contents
        context.save(nil)
        
        // Navigate back to root vc
        self.navigationController?.popToRootViewControllerAnimated(true)
      //  println(newItem)
    }
}
