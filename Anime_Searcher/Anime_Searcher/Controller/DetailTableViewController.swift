//
//  DetailTableViewController.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 21/04/21.
//

import Foundation
import UIKit
import Alamofire

class DetailTableViewController
: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    
    // MARK: - Variables
    var data: AnimeData? //Data that came from previous cell
    var episodes: [EpisodeData] = []
    var selectedEpisode: EpisodeData?
    
    //MARK: - Outlets
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    //@IBOutlet weak var detailGenre: UILabel!
    //@IBOutlet weak var detailHour: UILabel!
    @IBOutlet weak var detailSummary: UILabel!
   // @IBOutlet weak var detailTableView: UITableView!
   // @IBOutlet weak var coverImage: UIImageView!
    
    //MARK: - ViewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //unwrapping data
        if(data != nil) {
            
            detailTitle.text = data?.attributes.canonicalTitle
            detailSummary.text = data?.attributes.synopsis
            fetchImage(URL: (data?.attributes.posterImage?.small ?? "") )
            
        }
        
        //detailTableView.delegate = self
       // detailTableView.dataSource = self
        fetchEpisode()
    }
    
    func fetchImage(URL: String) {
        var tempImage: UIImage = UIImage()
        
        _ = AF.request(URL, method: .get).response{ (response) in
            switch response.result {
            case .success(let responseData):
                tempImage = UIImage(data: responseData!, scale: 1) ?? tempImage
                self.detailImage.image = tempImage
            break
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func fetchEpisode() {
        
        var url = ""
        
        if let showId = data?.id {
            url = "https://kitsu.io/api/edge/anime/\(showId)/episodes"
        }
        
        let request = AF.request(url)
        
        request.responseJSON { (response) in
            
            switch response.result {
            
            case .success:
                do {
                    self.episodes.removeAll()
                    let episode = try JSONDecoder().decode([EpisodeData].self, from: response.data!)
                    self.episodes.append(contentsOf: episode)
                    //self.detailTableView.reloadData()
                    print("Episodios: ", self.episodes)
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
                print("Deu erro pedindo episodio: \(error.localizedDescription) \(String(describing: error.failedStringEncoding))")
            break
            }
            
            
        }
    }
    
    
    //MARK: - TableViews
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        label.backgroundColor = UIColor.systemTeal
        
        return label
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return episodes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episode = episodes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as! DetailCell
        cell.setCell(episode: episode, indexPath.row)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      selectedEpisode = episodes[indexPath.row]
        
      return indexPath
    }
    
    //MARK: - Segue preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      guard let destinationVC = segue.destination as? EpisodeViewController else {
        return
      }
        destinationVC.data = selectedEpisode
    }
    
}
