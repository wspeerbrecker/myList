//
//  List.swift
//  myList
//
//  Created by Admin on 2015-08-12.
//  Copyright (c) 2015 infoshare. All rights reserved.
//

import Foundation
import CoreData

class List: NSManagedObject {

    @NSManaged var item: String
    @NSManaged var quantity: String
    @NSManaged var info: String

}
