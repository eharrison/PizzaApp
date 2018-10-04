//
//  PizzaDetailsViewControllerModel.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/4/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

fileprivate enum PizzaDetailsCellType: String {
    case cover
    case ingredientTitle
    case ingredient
}

fileprivate struct PizzaDetailsCellObject {
    var type: PizzaDetailsCellType = .cover
    var ingredient: Ingredient?
    var selected: Bool = false
    
    init(type: PizzaDetailsCellType, ingredient: Ingredient? = nil, selected: Bool = false) {
        self.type = type
        self.ingredient = ingredient
        self.selected = selected
    }
}

protocol PizzaDetailsViewControllerModelDelegate: class {
    func dataRequestFailed(_ error: Error)
}

public class PizzaDetailsViewControllerModel: NSObject {
    
    fileprivate var cells: [PizzaDetailsCellObject] = []
    var pizzaPayload: PizzaPayload?
    var pizza: Pizza?
    var ingredients: [Ingredient] = []
    
    weak var delegate: PizzaDetailsViewControllerModelDelegate?
    
    func refreshContent(withTableView tableView: UITableView) {
        reloadContent(tableView)
    }
    
    fileprivate func reloadContent(_ tableView: UITableView) {
        tableView.isScrollEnabled = true
        self.cells = self.contentCells()
        tableView.reloadData()
    }
    
    fileprivate func contentCells() -> [PizzaDetailsCellObject] {
        var cells = [PizzaDetailsCellObject]()
        
        cells.append(PizzaDetailsCellObject(type: .cover))
        cells.append(PizzaDetailsCellObject(type: .ingredientTitle))
        
        // add cells
        for ingredient in ingredients {
            cells.append(PizzaDetailsCellObject(type: .ingredient, ingredient: ingredient, selected: pizza?.hasIngredient(withId: ingredient.id) ?? false))
        }
        
        return cells
    }
    
}

// MARK: - Table view data source

extension PizzaDetailsViewControllerModel: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Quantity
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    // MARK: - Cell Configuration
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row].type.rawValue, for: indexPath)
        
        if let cell = cell as? IngredientTableViewCell {
            cell.nameLabel.text = cells[indexPath.row].ingredient?.name
            cell.priceLabel.text = "$\(cells[indexPath.row].ingredient?.price ?? 0)"
            cell.selectedImageView.isHidden = !cells[indexPath.row].selected
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PizzaCoverTableViewCell {
            cell.coverImageView.setImage(pizza?.imageUrl)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cells[indexPath.row].type == .ingredient {
            cells[indexPath.row].selected = !cells[indexPath.row].selected
            tableView.reloadData()
        }
    }
    
    // MARK: - Dimensions
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row].type {
        case .cover:
            return 200
        case .ingredientTitle:
            return 60
        case .ingredient:
            return 40
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row].type {
        case .cover:
            return 200
        case .ingredientTitle:
            return 60
        case .ingredient:
            return 40
        }
    }
    
}
