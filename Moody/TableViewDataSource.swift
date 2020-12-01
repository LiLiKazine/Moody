//
//  TableViewDataSource.swift
//  Moody
//
//  Created by yingkelei on 2020/11/30.
//

import UIKit
import CoreData
protocol TableViewDataSourceDelegate: class {
    associatedtype Object: NSFetchRequestResult
    associatedtype Cell: UITableViewCell
    
    func config(_ cell: Cell, for object: Object)
}

class TableViewDataSource<Delegate: TableViewDataSourceDelegate>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    let tableView: UITableView
    let cellIdentifier: String
    let fetchedResultsController: NSFetchedResultsController<Object>
    weak var delegate: Delegate?
    
    required init(tableView: UITableView, cellIdentifier: String,
                  fetchedResultsController: NSFetchedResultsController<Object>,
                  delegate: Delegate) {
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.fetchedResultsController = fetchedResultsController
        self.delegate = delegate
        super.init()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch let err {
            fatalError("Fetch failed with error: \(err.localizedDescription)")
        }
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let num = fetchedResultsController.sections?.count else { return 0 }
        return num
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = fetchedResultsController.object(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell else {
            fatalError("Unexpected cell type at \(indexPath)")
        }
        delegate?.config(cell, for: object)
        return cell
    }
}

