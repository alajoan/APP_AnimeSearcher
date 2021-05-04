//
//  AnimeDetailCollectionViewController.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 02/05/21.
//

import UIKit
import Alamofire

class AnimeDetailCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    var data: AnimeData? //Data that came from previous cell
    var episodes: [EpisodeData] = []
    var selectedEpisode: EpisodeData?
    
    @IBOutlet weak var animeDetailCover: UIImageView!
    @IBOutlet weak var animeDetailPoste: UIImageView!
    @IBOutlet weak var animeDetailTitle: UILabel!
    @IBOutlet weak var animeDetailSummary: UILabel!
    @IBOutlet weak var animeDetailCollectionView: UICollectionView!
    @IBOutlet weak var animeDetailTitleJapanese: UILabel!
    @IBOutlet weak var animeDetailStatus: UILabel!
    @IBOutlet weak var animeDetailRating: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animeDetailCollectionView.delegate = self
        animeDetailCollectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        if(data != nil) {
            animeDetailTitle.text = data?.attributes.canonicalTitle
            animeDetailSummary.text = data?.attributes.synopsis
            animeDetailTitleJapanese.text = "\(data?.attributes.titles.ja_jp ?? "N/A") | \(data?.attributes.titles.en_jp ?? "N/A")"
            animeDetailStatus.text = "Status: \(data?.attributes.status ?? "N/A")"
            animeDetailRating.text = "Average rating: \(data?.attributes.averageRating ?? "N/A")"
            DataFetching.fetchImage(URL: data?.attributes.posterImage?.small ?? "") { (animePoster) in
                self.animeDetailPoste.image = animePoster
            }
            
            DataFetching.fetchImage(URL: data?.attributes.coverImage?.small ?? "https://i.imgur.com/vISPEmn.png") { (animeCover) in
                self.animeDetailCover.image = animeCover
            }
            
            DataFetching.fetchEpisodes(data?.id ?? "") { (animeEpisodes) in
                self.episodes = animeEpisodes
                self.animeDetailCollectionView.reloadData()
            }
        } else {
            print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nSem dados: \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
        }
    }
    

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let episode = episodes[indexPath.item]
        
        let cell = animeDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "animeEpisodeCell", for: indexPath) as! DetailCollectionViewCell
        
        cell.setCell(animeEpisode: episode)
    
        return cell

    }
    
}
