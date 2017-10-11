//
//  ViewController.swift
//  TestTable
//
//  Created by Elano on 11/10/2017.
//  Copyright © 2017 Elano. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    private var array = [Bool]()
    private var lastIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ..< 10 {
            array.append(false)
        }
    }

    private func showHideBig(indexPath: IndexPath)
    {
        let oldIndex = self.lastIndexPath?.row ?? -1
        let needInsert = oldIndex != indexPath.row
        let newBigIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        
        self.tableView.beginUpdates()
        
        if let indexPath = self.lastIndexPath {
            let row = indexPath.row + 1
            self.lastIndexPath = nil
            
            if array[row] {
                array.remove(at: row)
                self.tableView.deleteRows(at: [IndexPath(item: row, section: indexPath.section)], with: .top)
            }
        }

        if needInsert {
            array.insert(true, at: newBigIndexPath.row)
            self.tableView.insertRows(at: [newBigIndexPath], with: .top)
            self.lastIndexPath = indexPath
        }
        
        self.tableView.endUpdates()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let value = self.array[indexPath.row]
        let idetifier = !value ? "normal" : "big"
        let cell = tableView.dequeueReusableCell(withIdentifier: idetifier, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !array[indexPath.row] {
            showHideBig(indexPath: indexPath)
        }
    }
}
