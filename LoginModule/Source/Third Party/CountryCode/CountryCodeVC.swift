// 
 //   CountryCodeVC.swift
 //   JOBSTOAPP
 // 
 //   Created by Vinitha on 27/12/18.
 //   Copyright © 2018 Apple. All rights reserved.
 // 

 import UIKit

struct CountryCodeModel: Codable {

    var code: String?
    var dialCode: String?
    var name: String?

    init(from decoder: Decoder) {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            code = try values.decodeIfPresent(String.self, forKey: .code)
            dialCode = try values.decodeIfPresent(String.self, forKey: .dialCode)
            name = try values.decodeIfPresent(String.self, forKey: .name)
        } catch {
            print(error)
        }
    }
 }

protocol CountryCodeProtocol {
    func updateCountryCode(dic: CountryCodeModel)
}

 class CountryCodeVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - Variables
    var countryArray = [CountryCodeModel]()
    var delegate: CountryCodeProtocol?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUIFont()
        //  Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.tableFooterView = UIView()
        readJson()
    }

    func setupUI() {
        searchBar.delegate = self
    }

    func setupUIFont() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: 15)
        } else {
            // Fallback on earlier versions
        }
    }

    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "countryCodes", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let decoder = JSONDecoder.init()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let model = try? decoder.decode([CountryCodeModel].self, from: data) {
                    self.countryArray = model
                }
                self.tableView.delegate = self
                self.tableView.dataSource = self

                self.tableView.reloadData()
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //  Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonActionMethod(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }

    /*
     // MARK: - Navigation
     
     //  In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     //  Get the new view controller using segue.destinationViewController.
     //  Pass the selected object to the new view controller.
     }
     */

 }

 extension CountryCodeVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return self.total
        return self.countryArray.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "CountryCodeCell", bundle: nil), forCellReuseIdentifier: "CountryCodeCell")
        guard let cell: CountryCodeCell = tableView.dequeueReusableCell(withIdentifier: "CountryCodeCell", for: indexPath) as? CountryCodeCell else {
            return UITableViewCell()
        }
        cell.lblCountryName.font = UIFont.systemFont(ofSize: 16)
        cell.lblCountryCode.font = UIFont.systemFont(ofSize: 16)
        let dic = self.countryArray[indexPath.row]
        cell.lblCountryName.text = dic.name
        cell.lblCountryCode.isHidden = false
        cell.lblCountryCode.text = dic.dialCode
        cell.mapImg.image = UIImage(named: dic.code ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let dic = self.countryArray[indexPath.row]
        self.delegate?.updateCountryCode(dic: dic)
        self.dismiss(animated: true, completion: nil)
    }
 }

 // MARK: - UISearchBarDelegate
 extension CountryCodeVC: UISearchBarDelegate {

     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count != 0 {
            let filterArray = countryArray.filter({
                ($0.name?.lowercased().contains(searchText.lowercased()) ?? false)
            })

            if  filterArray.count > 0 {
                countryArray.removeAll()
                countryArray = filterArray
                self.tableView.reloadData()
            }
        } else {
            countryArray.removeAll()
            readJson()
        }
     }

     func searchBarTextDidBeginEditing(_ searchBar_: UISearchBar) {

         searchBar.setShowsCancelButton(true, animated: true)
     }

     func searchBarTextDidEndEditing(_ searchBar_: UISearchBar) {

         searchBar.setShowsCancelButton(false, animated: true)
     }

    func searchBarCancelButtonClicked(_ searchBar_: UISearchBar) {

        searchBar.text = ""
        searchBar.resignFirstResponder()
        countryArray.removeAll()
        readJson()
    }

     func searchBarSearchButtonClicked(_ searchBar_: UISearchBar) {

         searchBar.resignFirstResponder()
     }
 }
