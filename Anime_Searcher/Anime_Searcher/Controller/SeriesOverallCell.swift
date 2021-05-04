//
//  SeriesOverallCell.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 21/04/21.
//

import UIKit
import Alamofire

class SeriesOverallCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var serieTitle: UILabel!
    @IBOutlet public weak var serieImage: UIImageView!
    @IBOutlet weak var serieCellView: UIView!
    
    //Fetch the image
    func getImage(URL: String) {
        var tempImage: UIImage = UIImage()
        
        _ = AF.request(URL, method: .get).response{ (response) in
            switch response.result {
            case .success(let responseData):
                tempImage = UIImage(data: responseData!, scale: 1) ?? tempImage
                self.serieImage.image = tempImage
            break
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    
    func setCell(anime: AnimeData) {
        
       /* getImage(URL: anime.data[index].attributes.posterImage ?? "https://cdn.neemo.com.br/uploads/settings_webdelivery/logo/4501/error-image-generic.png")*/
        
        if let unwrapperImage = anime.attributes.posterImage?.small  {
            getImage(URL: unwrapperImage)
        }
        
        serieTitle.text = anime.attributes.canonicalTitle
        
        // FIXME: Shadows lagging
        //Shadows for the cell
        serieCellView.layer.shadowPath = UIBezierPath(rect: serieCellView.bounds).cgPath
        serieCellView.layer.shadowRadius = 5
        serieCellView.layer.shadowOffset = .zero
        serieCellView.layer.shadowOpacity = 0.1
        serieCellView.layer.cornerRadius = 10
    }

}
