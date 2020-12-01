//
//  NSManagedObjectContext+Extension.swift
//  Moody
//
//  Created by yingkelei on 2020/12/1.
//

import CoreData

extension NSManagedObjectContext {
    
    func insertObject<T: NSManagedObject>() -> T where T: Managed {
        guard let object = NSEntityDescription
                .insertNewObject(forEntityName: T.entityName, into: self) as? T
        else { fatalError("Inserting wrong object type.") }
        return object
    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch let err {
            print(err.localizedDescription)
            rollback()
            return false
        }
    }
    
    func performChanges(completion: @escaping (_ success: Bool) -> Void) {
        perform {
            let res = self.saveOrRollback()
            completion(res)
        }
    }
}
