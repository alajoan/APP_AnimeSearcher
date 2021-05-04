//
//  MainCollectionViewCell.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 02/05/21.
//

import UIKit
import Alamofire

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeImage: UIImageView!
    
    func setCell(anime: AnimeData) {
        
       /* getImage(URL: anime.data[index].attributes.posterImage ?? "https://cdn.neemo.com.br/uploads/settings_webdelivery/logo/4501/error-image-generic.png")*/
        
        if let unwrapperImage = anime.attributes.posterImage?.small  {
            DataFetching.fetchImage(URL: unwrapperImage) { (animeImage) in
                self.animeImage.image = animeImage
            }
        }
        
        animeTitle.text = anime.attributes.canonicalTitle
    }
    

}
