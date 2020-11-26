//
//  ViewController.swift
//  PracticaWeather
//
//  Created by user on 20/11/2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {


    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var icoTemp: UIImageView!
    @IBOutlet weak var tableWeater: UITableView!
    @IBOutlet weak var labelRegion: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func updateWeather(_ sender: Any) {
        let nameCity: String = textField.text!
        getCityDetail(name: nameCity)
    }
    
    let searchController = UISearchController(searchResultsController: nil)
//    extension ViewController: UISearchResultsUpdating {
        func updateSearchResultats(for searchController: UISearchController){
            
        }
//    }
    
    var array = ["Мурманск", "Уфа", "Екатеринбург", "Мелеуз", "Салават", "Стерлитамак", "Москва","Гагра", "Сочи"]
    var arrCity = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Погода"
        tableWeater.delegate = self
        tableWeater.dataSource = self
        // Do any additional setup after loading the view.
        for cityItem in array {
            setCityArray(name: cityItem)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCityDetail(name: "Москва")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCity.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TempTableViewCell
        cell.labelCityName.text = arrCity[indexPath.row].name
        cell.labelCityTemp.text = arrCity[indexPath.row].temp
        cell.labelTime.text = arrCity[indexPath.row].time
        cell.iconCityTemp.image = UIImage(data: try! Data(contentsOf: URL(string: arrCity[indexPath.row].icon)!))
        cell.bacgroundCell.image = UIImage(data: try! Data(contentsOf: URL(string: "https://downloadwallpaperhd.net/laptop-wallpapers/miui-8-weather-wallpaper-wide-For-Laptop-Wallpaper.png")!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    func getCityDetail(name: String) {
        let url = "https://api.weatherapi.com/v1/current.json?key=\(token)&q=\(name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url as! URLConvertible, method: .get).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.labelCity.text = name
                    self.labelTemp.text = json["current"]["temp_c"].stringValue
                    self.labelRegion.text = json["location"]["region"].stringValue
                    let iconString = "https:\(json["current"]["condition"]["icon"].stringValue)"
                    self.icoTemp.image = UIImage.init(data: try! Data(contentsOf: URL(string: iconString)!))
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    func setCityArray(name: String) {
        let url = "https://api.weatherapi.com/v1/current.json?key=\(token)&q=\(name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(url as! URLConvertible, method: .get).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let temp = json["current"]["temp_c"].stringValue
                    let icon = "https:\(json["current"]["condition"]["icon"].stringValue)"
                    let time = json["location"]["localtime"].stringValue
                    self.arrCity.append(City(name: name, temp: temp, icon: icon, time: time))
                    self.tableWeater.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    
    struct City {
        var name: String
        var temp: String
        var icon: String
        var time: String
    }

}

