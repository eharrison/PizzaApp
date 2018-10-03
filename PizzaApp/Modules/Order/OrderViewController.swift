//
//  OrderViewController.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = OrderViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

// MARK: - OrderViewControllerModelDelegate

extension OrderViewController: OrderViewControllerModelDelegate {
    
    func dataRequestFailed(_ error: Error) {
        
    }
    
    func fetchData() {
        viewModel.refreshContent(withTableView: tableView)
    }
}
