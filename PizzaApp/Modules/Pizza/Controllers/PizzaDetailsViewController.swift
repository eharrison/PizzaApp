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
    @IBOutlet weak var changeButton: UIButton!
    
    var viewModel = PizzaDetailsViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        viewModel.delegate = self
        
        title = viewModel.title
        updateState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshContent(withTableView: tableView)
    }
    
    // MARK: - Events
    
    private func updateState() {
        addButton.isHidden = viewModel.isEditing
        changeButton.isHidden = !viewModel.isEditing
    }
    
    @IBAction func addToCart(_ sender: Any) {
        viewModel.addToCart()
    }
    
    @IBAction func changeOrder(_ sender: Any) {
        viewModel.changeOrder()
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - PizzaDetailsViewControllerModelDelegate

extension PizzaDetailsViewController: PizzaDetailsViewControllerModelDelegate {
    
    func priceUpdated(_ price: Double) {
        addButton.setTitle("ADD TO CART ($\(price))", for: .normal)
        changeButton.setTitle("UPDATE ORDER ($\(price))", for: .normal)
    }
}
