//
//  ViewController.swift
//  Countries
//
//  Created by Baha Orhan on 7.07.2022.
//

import UIKit

class HomePageViewController: UIViewController {
    
    var savedCountriesOnHomeVc: [String] = []
    var countryDataSource = CountryDataSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        countryDataSource.delegate = self
        countryDataSource.loadCountryList()
        print(savedCountry.name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! HomePageTableViewCell
            if let indexPath = self.tableView.indexPath(for: cell) {
                let country = countryDataSource.getCountryForIndex(index: indexPath.row)
                let DetailCardViewController = segue.destination as! DetailCardViewController
                DetailCardViewController.selectedCountry = country
            }
    }
}



extension HomePageViewController: CountryDataSourceDelegate {
    func countryListLoaded() {
        tableView.reloadData()
    }
}



extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
             didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryDataSource.getNumberOfCountry()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageCell", for: indexPath) as! HomePageTableViewCell
        let country = countryDataSource.getCountryForIndex(index: indexPath.row)
        cell.countryNameLabel.text = country.name
        cell.view.layer.borderWidth = 2
        cell.view.layer.borderColor = UIColor.gray.cgColor
        cell.view.layer.cornerRadius = 10
        cell.saveButton.tintColor = .gray
        if savedCountry.name.contains(country.name) {
                cell.saveButton.tintColor = .black
        } else {
            cell.saveButton.tintColor = .gray
        }
        return cell
    }
}
