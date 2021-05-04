//
//  EpisodeViewController.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 21/04/21.
//


import Foundation
import UIKit
import Alamofire

class EpisodeViewController:  UIViewController {
    //MARK: - Variables
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeNumber: UILabel!
    @IBOutlet weak var episodeSeason: UILabel!
    @IBOutlet weak var episodeSummary: UILabel!
    
    //data that came from previous View
    var data: EpisodeData?
    
    func getImage(URL: String) {
        var tempImage: UIImage = UIImage()
        
        _ = AF.request(URL, method: .get).response{ (response) in
            switch response.result {
            case .success(let responseData):
                tempImage = UIImage(data: responseData!, scale: 1) ?? tempImage
                self.episodeImage.image = tempImage
            break
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    //MARK: - ViewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodeSummary.text = Utils.cleanSummary(data?.attributes?.synopsis ?? "")
        
        getImage(URL: data?.attributes?.thumbnail?.original ?? "https://cdn.neemo.com.br/uploads/settings_webdelivery/logo/4501/error-image-generic.png")
        
        
    }
}

