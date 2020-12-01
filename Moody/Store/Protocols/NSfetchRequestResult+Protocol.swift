//
//  NSfetchRequestResult+Protocol.swift
//  Moody
//
//  Created by yingkelei on 2020/11/30.
//

import UIKit
import CoreData

protocol Managed: class, NSFetchRequestResult {
    static var entityName: String {get}
    static var defaultSortDescriptors: [NSSortDescriptor] {get}
}

extension Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    static var sortedFetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
}

extension Managed where Self: NSManagedObject {
    static var entityName: String {
        guard let name = entity().name else {
            fatalError("Entity name is nil: \(self.description())")
        }
        return name
    }
}
