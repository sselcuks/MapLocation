//
//  TripCell.swift
//  VoltLinesCaseProject
//
//  Created by Selcuk on 2.01.2022.
//

import UIKit

class TripCell: UITableViewCell {
    // XI
    
    @IBOutlet weak var busName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var bookBtn: UIButton!
    
    
    var selectedLoc: Trip!{
        didSet{
            busName.text = selectedLoc.busName
            time.text = selectedLoc.time
            bookBtn.setTitle("Book", for: .normal)
            bookBtn.layer.cornerRadius = 16
            bookBtn.clipsToBounds = true
           
        }
    }
    
    
}
