//
//  ZADashboardTableViewCell.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZADashboardTableViewCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var fromLabel: UILabel!
    @IBOutlet private weak var toLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var contactButton: UIButton!
    private var contactCompletion: EmptyCompletion!
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Public Methods
    
    public func configure(sender feed: SenderFeed, contactAction: @escaping EmptyCompletion) {
        contactCompletion = contactAction
        nameLabel.text = feed.name
        fromLabel.text = feed.source
        toLabel.text = feed.destination
        typeLabel.text = "-"
        weightLabel.text = feed.weight + "" + (feed.weightUnit ?? "")
        priceLabel.text = feed.price + " " + feed.priceUnit.getCurrencyOfString();
    }
    
    public func configure(traveler feed: SenderFeed, contactAction: @escaping EmptyCompletion) {
        contactCompletion = contactAction
        nameLabel.text = feed.name
        fromLabel.text = feed.source
        toLabel.text = feed.destination
        typeLabel.text = "-"
        weightLabel.text = feed.weight + "" + (feed.weightUnit ?? "")
        priceLabel.text = feed.price + " " + feed.priceUnit.getCurrencyOfString();
    }
    
    
    // MARK: - Action Methods
    
    @IBAction private func contactButtonTapped(_ sender: UIButton) {
        contactCompletion()
    }
    
}
