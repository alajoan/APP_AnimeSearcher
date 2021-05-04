//
//  DetailCollectionViewCell.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 02/05/21.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var animeDetailEpisodeImage: UIImageView!
    @IBOutlet weak var animeDetailEpisodeNumber: UILabel!
    
    var episodes: [EpisodeData] = []
    
    func setCell(animeEpisode: EpisodeData) {
        if let unwrappingEpisodeNumber = animeEpisode.attributes?.number {
            animeDetailEpisodeNumber.text = "Episode \(unwrappingEpisodeNumber)"
        }
        
        DataFetching.fetchImage(URL: animeEpisode.attributes?.thumbnail?.original ?? "https://i.imgur.com/oYU30Xq.png") { (thumbnailImage) in
            self.animeDetailEpisodeImage.image = thumbnailImage
        }
        
        
    }
    
    
}
