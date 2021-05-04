//
//  DetailCell.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 21/04/21.
//


import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var episodeLabel: UILabel!
    
    func setCell(episode: EpisodeData, _ index: Int) {
        episodeLabel.text = "Episode \(String(describing: episode.attributes?.number))"
        
    }

}
