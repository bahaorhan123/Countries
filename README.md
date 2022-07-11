# Countries
API Based Swift Project

Main aim of this project is using APIs to illustrate datas on TableView and with help of SVGKit
using .svg images on Detail View for each TableViewCell.

## Prerequisites
First, SVGKit package has to be added on project. In XCode, go to File -> Add Packages... and provide URL below, and choose Dependency Role.

For more information and package URL for XCode:

[SVGKit](https://github.com/SVGKit/SVGKit)

## APIs

In this project, we will use country API datas to add contents on TableView cells. First API is

[https://wft-geo-db.p.rapidapi.com/v1/geo/countries/?rapidapi-key=RAPIDAPI_KEY](https://wft-geo-db.p.rapidapi.com/v1/geo/countries?rapidapi-key=RAPIDAPI_KEY)

Example Endpoint Data:

```bash
{
  "code": "VA",
  "currencyCodes": [
      "EUR"
  ],
  "name": "Vatican City",
  "wikiDataId": "Q237"
}
```

We will use another API datas to use illustrate the flag images of each country on their Detail Card Views.

[https://wft-geo-db.p.rapidapi.com/v1/geo/countries/{code}/?rapidapi-key=RAPIDAPI_KEY](https://wft-geo-db.p.rapidapi.com/v1/geo/countries{code}/?rapidapi-key=RAPIDAPI_KEY)

Where {code} is 2-letter country code. For example "US".

Example Endpoint Data:

```bash
{
    "data": {
        "capital": "Washington, D.C.",
        "code": "US",
        "callingCode": "+1",
        "currencyCodes": [
            "USD"
        ],
        "flagImageUri": "http://commons.wikimedia.org/wiki/Special:FilePath/Flag%20of%20the%20United%20States.svg",
        "name": "United States of America",
        "numRegions": 57,
        "wikiDataId": "Q30"
    }
}
```

Postman is very useful application to check the endpoints and work on APIs. It is recommended to use.

[Postman](https://www.postman.com)

## HomePage and Saved Views

First, Home Page and Saved views will be connected to Tab Bar, and home page is first tab. 

Home Page view is used to get all countries on TableView anf country datas will be used from first API. Names will be listed on table and each cell has saveButton to save countries on "savedCountry".

To use save button, addTarget() function and @objc func toogle() are used on HomePageTableViewCell.

```swift
saveButton.addTarget(self, action: #selector(toogle), for: .touchUpInside)
```
```swift
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
```

Other view that Saved will be used to illustrate savedCountry array. Also, cells on this view have saveButton to unsave country. If button is tapped, TableView on Saved View will delete according cell.

First, for reaching tableView on SavedCountriesViewController from SavedCountriesTableViewCell "link" is created.

SavedCountriesTableViewCell:
```swift
var link: SavedCountriesViewController?
```
SavedCountriesViewController:
```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCountriesCell") as! SavedCountriesTableViewCell
        cell.link = self
}
```

To use save button on Saved View, addTarget() and @objc func toogle is used.

```swift
saveButton.addTarget(self, action: #selector(toogle), for: .touchUpInside)
```

```swift
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
```

## Detail Card View

At endpoint data, "flagImageUri" is .svg based image data. First SVGKit that is added package on project has to be imported.

```swift
import SVGKit
```

To use SVG image extention for UIImageView is used on DetailCardViewController.

```swift
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
```

Than,

```swift
countryFlagImage.downloaded(from: url, contentMode: .scaleAspectFit)
```

There is a button on each country detail card for using web page to get for information about it. "wikiDataId" will be used for each "For More Information" button. This button will send to link that:

[https://www.wikidata.org/wiki/wikiDataId](https://www.wikidata.org/wiki/wikiDataId)

For example:

[https://www.wikidata.org/wiki/Q30](https://www.wikidata.org/wiki/Q30)

## Screen Shots of Screens

![Simulator Screen Shot - iPhone 13 - 2022-07-10 at 22 59 37](https://user-images.githubusercontent.com/67962494/178160326-138cda72-6ad8-4345-bd00-c561875cc8b7.png)

![Simulator Screen Shot - iPhone 13 - 2022-07-10 at 22 59 53](https://user-images.githubusercontent.com/67962494/178160383-35afbfae-a5b4-4f38-b63f-516ddb57ad3b.png)

![Simulator Screen Shot - iPhone 13 - 2022-07-10 at 23 00 09](https://user-images.githubusercontent.com/67962494/178160387-2c99d41a-ab89-4cef-8be2-0ba80aa61b77.png)

![Simulator Screen Shot - iPhone 13 - 2022-07-10 at 23 00 16](https://user-images.githubusercontent.com/67962494/178160389-ba94fb96-8d71-4ffe-b355-9ddc11f76cfb.png)


