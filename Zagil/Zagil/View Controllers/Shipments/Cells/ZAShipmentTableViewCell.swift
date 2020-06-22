//
//  ZAShipmentTableViewCell.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 01/05/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ZAShipmentTableViewCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var fromLocationLabel: UILabel!
    @IBOutlet private var fromClockLabel: UILabel!
    @IBOutlet private var toLocationLabel: UILabel!
    @IBOutlet private var toClockLabel: UILabel!
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor(named: "#000029")?.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        containerView.layer.shadowRadius = 6
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Public Methods
    
    public func configure(shipment: PostedShipment) {
        fromLocationLabel.text = shipment.source
        fromClockLabel.text = shipment.date.toDate(format: .dd_MM_YYYY)?.getString(of: .EEEE_MMM_d_yyyy) ?? ""
        toLocationLabel.text = shipment.destination
        toClockLabel.text = ""
    }
    
    public func configure(trip: PostedTrip) {
        fromLocationLabel.text = trip.source
        fromClockLabel.text = trip.startDate.toDate(format: .dd_MM_YYYY)?.getString(of: .EEEE_MMM_d_yyyy) ?? ""
        toLocationLabel.text = trip.destination
        toClockLabel.text = trip.startDate.toDate(format: .dd_MM_YYYY)?.getString(of: .EEEE_MMM_d_yyyy) ?? ""
    }
    
}
