//
//  DataFetching.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 03/05/21.
//

import Foundation
import Alamofire

class DataFetching {
    
    static func fetchAnimes(_ nameSearched: String, completionHandler: @escaping([AnimeData]) -> Void){
        
        let cleanURL = Utils.cleanURL(URL: nameSearched)
        
        var animes: [AnimeData] = []
        
        let url = "https://kitsu.io/api/edge/anime?filter%5btext%5d=\(cleanURL)"
        
        let request = AF.request(url)
        
        request.responseJSON { (response) in
            
            switch response.result {
            
            case .success:
                do {
                    animes.removeAll()
                    let anime = try JSONDecoder().decode(AnimeRoot.self, from: response.data!)
                    animes.append(contentsOf: anime.data)
                    print("Recebendo os dados: \(animes)")
                    completionHandler(animes)
                    
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
    
    static func fetchEpisodes(_ episodeId: String, completionHandler: @escaping([EpisodeData]) -> Void){
        
        
        var episodes: [EpisodeData] = []
        
        let url = "https://kitsu.io/api/edge/anime/\(episodeId)/episodes?page%5blimit%5d=20"
        
        let request = AF.request(url)
        
        request.responseJSON { (response) in
            
            switch response.result {
            
            case .success:
                do {
                    episodes.removeAll()
                    let episode = try JSONDecoder().decode(EpisodeRoot.self, from: response.data!)
                    episodes.append(contentsOf: episode.data)
                    //print("Recebendo os dados: \(animes)")
                    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nDados baixados: \(episodes) \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                    completionHandler(episodes)
                
                    
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
    
    static func fetchImage(URL: String, completionHandler: @escaping(UIImage) -> Void) {
        
        var tempImage: UIImage = UIImage()
        
        _ = AF.request(URL, method: .get).response{ (response) in
            switch response.result {
            case .success(let responseData):
                tempImage = UIImage(data: responseData!, scale: 1) ?? tempImage
                completionHandler(tempImage)
            break
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
}


