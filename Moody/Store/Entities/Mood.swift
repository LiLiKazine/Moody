//
//  Mood.swift
//  Moody
//
//  Created by yingkelei on 2020/11/30.
//

import UIKit
import CoreData

final class Mood: NSManagedObject {
    
    @NSManaged fileprivate(set) var date: Date
    @NSManaged fileprivate(set) var colors: [UIColor]

}

extension Mood: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
    
    static func insert(into context: NSManagedObjectContext, image: UIImage) -> Mood {
        let mood: Mood = context.insertObject()
        mood.colors = image.moodColors
        mood.date = Date()
        return mood
    }
}
