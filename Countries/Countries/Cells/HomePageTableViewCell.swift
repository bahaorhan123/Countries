//
//  HomePageTableViewCell.swift
//  Countries
//
//  Created by Baha Orhan on 8.07.2022.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.addTarget(self, action: #selector(toogle), for: .touchUpInside)
    }
    
    @objc func toogle() {
        if saveButton.tintColor == .gray {
            savedCountry.name += ["\(countryNameLabel.text!)"]
            saveButton.tintColor = .black
        } else {
            saveButton.tintColor = .gray
            savedCountry.name = savedCountry.name.filter { $0 != countryNameLabel.text! }
        }
        print(savedCountry.name)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
