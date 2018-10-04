//
//  PizzaTableViewCell.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit

typealias AddToCartCallback = () -> Void

class PizzaTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    // callbacks
    var addToCartCallback: AddToCartCallback?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Events

    @IBAction func addToCart(_ sender: Any) {
        addToCartCallback?()
    }
    
}
