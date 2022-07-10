//
//  SavedCountriesViewController.swift
//  Countries
//
//  Created by Baha Orhan on 8.07.2022.
//

import UIKit

class SavedCountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var countryDataSource = CountryDataSource()
    var country: [Country] = []
    
    override func viewWillAppear(_ animated: Bool) {
        countryDataSource.delegate = self
        countryDataSource.loadCountryList()
        print(savedCountry.name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        print(country)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! SavedCountriesTableViewCell
            if let indexPath = self.tableView.indexPath(for: cell) {
                //let country = countryDataSource.getCountryForIndex(index: indexPath.row)
                let saved = savedCountry.name[indexPath.row]
                var countryToDetail = Country(code: "lkn", name: "", wikiDataId: "")
                for i in 0..<country.count {
                    if saved == country[i].name {
                        countryToDetail = country[i]
                        print(countryToDetail)
                    }
                }
                let DetailCardViewController = segue.destination as! DetailCardViewController
                DetailCardViewController.selectedCountry = countryToDetail
            }
    }
    
    
}



extension SavedCountriesViewController: CountryDataSourceDelegate {
    func countryListLoaded() {
        tableView.reloadData()
        country = countryDataSource.getCountryArray()
    }
}



extension SavedCountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
             didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCountry.name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCountriesCell") as! SavedCountriesTableViewCell
        cell.link = self
        let saved = savedCountry.name[indexPath.row]
        cell.countryNameLabel.text = saved
        cell.view.layer.borderWidth = 2
        cell.view.layer.borderColor = UIColor.gray.cgColor
        cell.view.layer.cornerRadius = 10
        cell.saveButton.tintColor = .black
        return cell
    }
}

