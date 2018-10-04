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
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    
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
        if let viewController = segue.destination as? PizzaDetailsViewController {
            viewController.viewModel.pizzaPayload = viewModel.pizzaPayload
            viewController.viewModel.ingredients = viewModel.ingredients
            
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                viewController.viewModel.pizza = viewModel.pizza(forIndexPath: indexPath)
            }
        }
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
