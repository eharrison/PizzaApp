//
//  CartViewController.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/4/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var drinkButton: UIBarButtonItem!
    @IBOutlet weak var checkoutButton: UIButton!
    
    var viewModel = CartViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshContent(withTableView: tableView)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Events
    
    @IBAction func addDrink(_ sender: Any) {
        
    }
    
    @IBAction func checkout(_ sender: Any) {
        Cart.shared.processOrder { [weak self] (success) in
            guard success else {
                self?.showAlert(withTitle: "Failed", message: "Something went wrong.", buttons: (UIAlertAction.Style.default, "Ok", nil))
                return
            }
            
            self?.showAlert(withTitle: "Success", message: "Your order has been placed.", buttons: (UIAlertAction.Style.default, "Ok", ( {
                Cart.shared.items.removeAll()
                self?.navigationController?.popViewController(animated: true)
            })))
        }
    }
    
}

// MARK: - PizzaDetailsViewControllerModelDelegate

extension CartViewController: CartViewControllerModelDelegate {
    
    
}
