//
//  OrderViewControllerModel.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

fileprivate enum OrderCellType: String {
    case pizza
    case pizzaSkeleton
}

fileprivate struct OrderCellObject {
    var type: OrderCellType = .pizza
    var pizza: Pizza?
    
    init(type: OrderCellType, pizza: Pizza? = nil) {
        self.type = type
        self.pizza = pizza
    }
}

protocol OrderViewControllerModelDelegate: class {
    func dataRequestFailed(_ error: Error)
}

public class OrderViewControllerModel: NSObject {
    
    fileprivate var cells: [OrderCellObject] = []
    var pizzaPayload: PizzaPayload?
    var ingredients: [Ingredient] = []
    
    weak var delegate: OrderViewControllerModelDelegate?
    
    func refreshContent(withTableView tableView: UITableView) {
        // skeleton cells
        reloadSkeleton(tableView)
        
        // load pizzas
        Pizza.list { [weak self] (pizzaPayload) in
            self?.pizzaPayload = pizzaPayload
            self?.reloadContent(tableView)
        }
        
        // load ingredients
        Ingredient.list { [weak self] (ingredients) in
            self?.ingredients = ingredients
            self?.reloadContent(tableView)
        }
    }
    
    fileprivate func reloadSkeleton(_ tableView: UITableView) {
        tableView.isScrollEnabled = false
        self.cells = self.skeletonCells()
        tableView.reloadData()
    }
    
    fileprivate func reloadContent(_ tableView: UITableView) {
        tableView.isScrollEnabled = true
        self.cells = self.contentCells()
        tableView.reloadData()
    }
    
    fileprivate func skeletonCells() -> [OrderCellObject] {
        var cells = [OrderCellObject]()
        
        // add skeleton cells
        cells.append(OrderCellObject(type: .pizzaSkeleton))
        cells.append(OrderCellObject(type: .pizzaSkeleton))
        cells.append(OrderCellObject(type: .pizzaSkeleton))
        cells.append(OrderCellObject(type: .pizzaSkeleton))
        
        return cells
    }
    
    fileprivate func contentCells() -> [OrderCellObject] {
        var cells = [OrderCellObject]()
        
        // add cells
        if let pizzaPayload = pizzaPayload {
            for pizza in pizzaPayload.pizzas {
                cells.append(OrderCellObject(type: .pizza, pizza: pizza))
            }
        }
        
        return cells
    }
    
    func pizza(forIndexPath indexPath: IndexPath) -> Pizza? {
        return cells[indexPath.row].pizza
    }
    
}

// MARK: - Table view data source

extension OrderViewControllerModel: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Quantity
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    // MARK: - Cell Configuration
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row].type.rawValue, for: indexPath)
        
        if let cell = cell as? PizzaTableViewCell {
            cell.nameLabel.text = cells[indexPath.row].pizza?.name
            cell.ingredientsLabel.text = cells[indexPath.row].pizza?.ingredientNames(forIngredients: ingredients)
            
            cell.priceButton.setTitle("$0 ", for: .normal)
            if let pizza = cells[indexPath.row].pizza, let price = pizzaPayload?.price(forPizza: pizza, withIngredients: ingredients) {
                cell.priceButton.setTitle("$\(price) ", for: .normal)
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PizzaTableViewCell {
            cell.coverImageView.setImage(cells[indexPath.row].pizza?.imageUrl)
        }
    }
    
    // MARK: - Dimensions
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row].type {
        case .pizza, .pizzaSkeleton:
            return 200
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row].type {
        case .pizza, .pizzaSkeleton:
            return UITableView.automaticDimension
        }
    }
    
}
