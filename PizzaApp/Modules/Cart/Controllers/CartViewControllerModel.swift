//
//  CartViewControllerModel.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/4/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

fileprivate enum CartCellType: String {
    case item
    case total
}

fileprivate struct CartCellObject {
    var type: CartCellType = .item
    var item: CartItem?
    
    init(type: CartCellType, item: CartItem? = nil) {
        self.type = type
        self.item = item
    }
}

protocol CartViewControllerModelDelegate: class {
    
}

public class CartViewControllerModel: NSObject {
    
    fileprivate var cells: [CartCellObject] = []
    var pizzaPayload: PizzaPayload?
    var ingredients: [Ingredient] = []
    
    weak var delegate: CartViewControllerModelDelegate?
    
    func refreshContent(withTableView tableView: UITableView) {
        reloadContent(tableView)
    }
    
    fileprivate func reloadContent(_ tableView: UITableView) {
        tableView.isScrollEnabled = true
        self.cells = self.contentCells()
        tableView.reloadData()
    }
    
    fileprivate func contentCells() -> [CartCellObject] {
        var cells = [CartCellObject]()
        
        // add cells
        for item in Cart.shared.items {
            cells.append(CartCellObject(type: .item, item: item))
        }
        
        cells.append(CartCellObject(type: .total))
        
        return cells
    }
    
}

// MARK: - Table view data source

extension CartViewControllerModel: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Quantity
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    // MARK: - Cell Configuration
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row].type.rawValue, for: indexPath)
        
        if let cell = cell as? CartItemTableViewCell {
            cell.nameLabel.text = cells[indexPath.row].item?.name
            cell.priceLabel.text = "$\(cells[indexPath.row].item?.price ?? 0)"
            cell.deleteCallback = { [weak self] in
                Cart.shared.items.remove(at: indexPath.row)
                self?.refreshContent(withTableView: tableView)
            }
        } else if let cell = cell as? CartTotalTableViewCell {
            cell.priceLabel.text = "$\(Cart.shared.total)"
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Dimensions
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row].type {
        case .item:
            return 40
        case .total:
            return 60
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row].type {
        case .item:
            return 40
        case .total:
            return 60
        }
    }
    
}

