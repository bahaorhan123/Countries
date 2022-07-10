//
//  SavedCountriesTableViewCell.swift
//  Countries
//
//  Created by Baha Orhan on 8.07.2022.
//

import UIKit

class SavedCountriesTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var countryNameLabel: UILabel!
   
    var link: SavedCountriesViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveButton.addTarget(self, action: #selector(toogle), for: .touchUpInside)
    }
    
    @objc func toogle() {
        if saveButton.tintColor == .black {
            
            var index = 0
            for i in 0..<savedCountry.name.count{
                if savedCountry.name[i]==countryNameLabel.text! {
                    index = i
                }
            }
            savedCountry.name = savedCountry.name.filter { $0 != countryNameLabel.text! }
            link?.tableView.beginUpdates()
            let indexPath = [IndexPath(row: index, section: 0)]
            link?.tableView.deleteRows(at: indexPath, with: .fade)
            link?.tableView.endUpdates()
            
            
            saveButton.tintColor = .gray
        }
        print(savedCountry.name)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
