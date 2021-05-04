//
//  MainCollectionViewController.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 02/05/21.
//

import UIKit
import Alamofire

class MainCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    // MARK: - Variables
    var animes: [AnimeData] = []
    var selectedItem: AnimeData? //data holder for the selected row to go through the segues
   
    // MARK: - ViewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundColor = .clear
        
    }
    
    // MARK: - Textfield and buttons
    @IBAction func searchPressed(_ sender: UIButton) {
        print("Button working")
        searchTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        DataFetching.fetchAnimes(searchTextField.text!) { (anime) in
            self.animes = anime
            self.mainCollectionView.reloadData()
        }
        
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
    
    //MARK: - Fetches
    
    
    //Segue preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animeDetailSegue" {
            if let destinationVc = segue.destination as? AnimeDetailCollectionViewController {
             destinationVc.data = selectedItem
            }
        }
    }
    

   
    // MARK: UICollectionViews

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animes.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let anime = animes[indexPath.item]
        
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "animeCell", for: indexPath) as! MainCollectionViewCell
        
        cell.setCell(anime: anime)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Indexpath: \(indexPath.item)")
        selectedItem = animes[indexPath.item]
        print("Selected item: \(String(describing: selectedItem))")
        performSegue(withIdentifier: "animeDetailSegue", sender: self)
        print("Selected at row: \(indexPath.row)")
    }
    
    

}
