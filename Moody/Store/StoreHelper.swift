//
//  StoreHelper.swift
//  Moody
//
//  Created by yingkelei on 2020/11/30.
//

import UIKit
import CoreData

final class StoreHelper {

    class func createMoodyContainer(completion: @escaping(NSPersistentContainer) -> Void) {
        let container = NSPersistentContainer(name: "Moody")
        container.loadPersistentStores { (_, err) in
            if let err = err {
                fatalError("Failed to load store: \(err.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    completion(container)
                }
            }
        }
        
    }
    
}
