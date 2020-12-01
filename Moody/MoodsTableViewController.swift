//
//  MoodsTableViewController.swift
//  Moody
//
//  Created by yingkelei on 2020/11/30.
//

import UIKit
import CoreData

class MoodsTableViewController: UITableViewController {
    
    private let container = AppStorage.shared.persistentContainer
    private var dataSource: TableViewDataSource<MoodsTableViewController>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard container != nil else {
            return
        }
        
        setupTableView()

    }
    
    
    private func setupTableView() {
        guard let context = container?.viewContext else {
            return
        }
        let request = Mood.sortedFetchRequest
        request.fetchBatchSize = 20
        request.returnsObjectsAsFaults = false
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = TableViewDataSource(tableView: tableView, cellIdentifier: "MoodCell", fetchedResultsController: frc, delegate: self)
        
    }

}

extension MoodsTableViewController: TableViewDataSourceDelegate {
    typealias Object = Mood
    typealias Cell = MoodCell
    
    func config(_ cell: Cell, for object: Object) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.dateLabel.text = dateFormatter.string(from: object.date)
    }
}
