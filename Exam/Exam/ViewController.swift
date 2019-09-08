//
//  ViewController.swift
//  Exam
//
//  Created by Dominic on 08/09/2019.
//  Copyright © 2019 Dominic. All rights reserved.
//

import UIKit

struct Country:Decodable {
    let name:String
    let alpha3Code:String
    let flag:String
    let capital:String
    let population:Int
}

class ViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var arrCountry = [Country]()
    var arrFiltered = [Country]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData()
    }
    
    func getJSONData(){
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            do
            {
                self.arrCountry = try JSONDecoder().decode([Country].self, from: data!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch
            {
                print("Failed to get data.")
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return arrFiltered.count
        } else {
            return arrCountry.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        if isSearching {
            cell.lblCode.text = arrFiltered[indexPath.row].alpha3Code
            cell.lblName.text = arrFiltered[indexPath.row].name
        } else {
            cell.lblCode.text = arrCountry[indexPath.row].alpha3Code
            cell.lblName.text = arrCountry[indexPath.row].name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailed", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? DetailedViewController{
            
            detail.countryCode = arrCountry[(tableView.indexPathForSelectedRow?.row)!].alpha3Code
            detail.countryName = "Name : \(arrCountry[(tableView.indexPathForSelectedRow?.row)!].name)"
            detail.countryCapital = "Capital : \(arrCountry[(tableView.indexPathForSelectedRow?.row)!].capital)"
            detail.countryPop = "Population: \(arrCountry[(tableView.indexPathForSelectedRow?.row)!].population)"
            detail.countryFlag = arrCountry[(tableView.indexPathForSelectedRow?.row)!].flag
        }
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        arrFiltered = arrCountry.filter({$0.name.prefix(searchText.count) == searchText})
        isSearching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
