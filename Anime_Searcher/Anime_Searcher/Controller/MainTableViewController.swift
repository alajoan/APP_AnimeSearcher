//
//  MainTableViewController.swift
//  Afya_Desafio
//
//  Created by Jonathan Alajoan Rocha on 21/04/21.
//

import Foundation
import Alamofire

class MainTableViewController
: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - Variables
    var animes: [AnimeData] = []
    var selectedItem: AnimeData? //data holder for the selected row to go through the segues
    
    // MARK: - Outlets
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var serieTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - ViewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldSearch.delegate = self
        serieTableView.delegate = self
        serieTableView.dataSource = self
        serieTableView.backgroundColor = .clear
        
    }
    
    // MARK: - Textfield and buttons
    @IBAction func searchPressed(_ sender: UIButton) {
        print("Button working")
        textfieldSearch.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Fetching...")
        fetchSeries(textfieldSearch.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != "") {
            return true
        } else {
            textField.placeholder = "Enter something to search"
            return false
        }
    }
    
    
    
    // MARK: - TableViews
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 150 // altura
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let anime = animes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "serieCell") as! SeriesOverallCell
        cell.setCell(anime: anime)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      selectedItem = animes[indexPath.row]
        
      return indexPath
    }

    
    //MARK: - Fetches
    func fetchSeries(_ nameSearched: String) {
        
        let cleanURL = Utils.cleanURL(URL: nameSearched)
            //cleanString(urlText: nameSearched)
        
        let url = "https://kitsu.io/api/edge/anime?filter%5btext%5d=\(cleanURL)"
        
        let request = AF.request(url)
        
        request.responseJSON { (response) in
            switch response.result {
            
            case .success:
                do {
                    self.animes.removeAll()
                    let anime = try JSONDecoder().decode(AnimeRoot.self, from: response.data!)
                    self.animes.append(contentsOf: anime.data)
                    print("Recebendo os dados: \(self.animes)")
                    self.serieTableView.reloadData()
                    
                } catch DecodingError.keyNotFound(let key, let context) {
                    Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
                break
                
            case .failure(let error):
                print("Deu erro: \(error.localizedDescription) \(String(describing: error.failedStringEncoding))")
            break
            }
            
            
        }
        
    }
    
    //Segue preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      guard let destinationVC = segue.destination as? DetailTableViewController else {
        return
      }
        destinationVC.data = selectedItem
    }
    
}
