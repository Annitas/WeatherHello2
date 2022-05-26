//
//  ViewController.swift
//  WeatherApp2
//
//  Created by Anita Stashevskaya on 26.05.2022.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self
    }


}

extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let key = "d2b758466054981c7a9596f7549c12be"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(searchBar.text!)&appid=\(key)&units=metric"
        let url = URL(string: urlString)
        
        var locationName: String?
        var temperature: Int?
        
        let task = URLSession.shared.dataTask(with: url!) {(data, responce, error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                }
                if let currentTemp = json["temp"] {
                    temperature = currentTemp["temp"] as? Int
                }
                
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
}
