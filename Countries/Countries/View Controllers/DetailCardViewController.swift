//
//  DetailCardViewController.swift
//  Countries
//
//  Created by Baha Orhan on 8.07.2022.
//

import UIKit
import SVGKit

class DetailCardViewController: UIViewController {

    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var forMoreInfoButton: UIButton!
    
    var urlString = ""
    var selectedCountry: Country?
    var countryDetailDataSource = CountryDetailDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCountry?.name
        
        countryDetailDataSource.delegate = self
        countryDetailDataSource.loadCountryDetails(x: selectedCountry!.code)
        countryCodeLabel.text = selectedCountry?.code
        urlString = "https://www.wikidata.org/wiki/\(selectedCountry?.wikiDataId ?? "")"
        // Do any additional setup after loading the view.
        if savedCountry.name.contains(selectedCountry!.name) {
            savedButton.tintColor = .black
        } else {
            savedButton.tintColor = .gray
        }
        
    }
    
    @IBAction func savedButtonTapped(_ sender: Any) {
        if savedCountry.name.contains(selectedCountry!.name) {
            savedCountry.name = savedCountry.name.filter { $0 != selectedCountry!.name }
            
            savedButton.tintColor = .gray
        } else {
            savedCountry.name += ["\(selectedCountry!.name)"]
            savedButton.tintColor = .black
        }
        print(savedCountry.name)
    }
    
    @IBAction func forMoreInformationTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string: urlString)! as URL)
    }
}



extension DetailCardViewController: CountryDetailDataSourceDelegate {
    func countryDetailListLoaded() {
       print(countryDetailDataSource.getURL())
        let imageURL = countryDetailDataSource.getURL()
        if let url = URL(string: imageURL) {
            countryFlagImage.downloaded(from: url, contentMode: .scaleAspectFit)
        }
    }
}



extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let imagesvg = SVGKImage(data: data),
                let image: UIImage = imagesvg.uiImage
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
