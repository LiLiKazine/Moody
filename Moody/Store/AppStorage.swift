//
//  AppStorage.swift
//  Moody
//
//  Created by yingkelei on 2020/11/30.
//

import UIKit
import CoreData

protocol AppStorageDelegate: class {
    func containerDidSet(_ container: NSPersistentContainer?)
}

final class AppStorage {
    static let shared = AppStorage()
    
    weak var delegate: AppStorageDelegate?
    
    var persistentContainer: NSPersistentContainer? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.containerDidSet(self.persistentContainer)
            }
        }
    }
    
    
    private init() {}
}
