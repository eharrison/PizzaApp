//
//  PizzaDetailsViewController.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/4/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class PizzaDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel = PizzaDetailsViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        viewModel.delegate = self
        
        title = viewModel.pizza?.name ?? "Custom Pizza"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshContent(withTableView: tableView)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Events
    
    @IBAction func addToCart(_ sender: Any) {
    }
    
}

// MARK: - PizzaDetailsViewControllerModelDelegate

extension PizzaDetailsViewController: PizzaDetailsViewControllerModelDelegate {
    
    func priceUpdated(_ price: Double) {
        addButton.setTitle("ADD TO CART ($\(price))", for: .normal)
    }
}
