//
//  CountryCodeDataSource.swift
//  Countries
//
//  Created by Baha Orhan on 7.07.2022.
//

import Foundation

class CountryDataSource {
    
    private var countryList: [Country] = []
    private var baseURL = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/?rapidapi-key=0888273872msh98678998017b2b7p12e4e2jsnfec4c20ff3c3"
    var delegate: CountryDataSourceDelegate?
    
    init() {
    }
    
    func getCountryArray() -> [Country] {
        return countryList
    }
    
    func getNumberOfCountry() -> Int {
        return countryList.count
    }
    
    func getCountryForIndex(index: Int) -> Country {
        let realIndex = index % countryList.count
        return countryList[realIndex]
    }
    
    
    func getCountryWithName(x: String) -> Country {
        var country = Country(code: "", name: "", wikiDataId: "")
        for i in 0..<(countryList.count) {
            if countryList[i].name == x {
                country = countryList[i]
            }
        }
        print(country)
        return country
    }
    
            
    
    func getCountries() -> [Country] {
        return countryList
    }

    
    func loadCountryList() {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let countryArrayFromNetwork = try decoder.decode(Others.self, from: data)
                        let countrydata = countryArrayFromNetwork.data
                        self.countryList = countrydata
                        DispatchQueue.main.async {
                            self.delegate?.countryListLoaded()
                        }
                    }catch {
                        print("error on decode: \(error.localizedDescription)")
                        print(String(describing: error))
                        print("here")
                    }
                }
            }
            dataTask.resume()
        }
    }
}
