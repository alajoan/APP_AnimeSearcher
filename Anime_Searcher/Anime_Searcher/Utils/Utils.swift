//
//  Utils.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 29/04/21.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Clean URls and summaries
class Utils {
    static func cleanURL(URL: String) -> String {
        var text:String = URL
        
        text = text.replacingOccurrences(of: "’", with: "")
        text = text.replacingOccurrences(of: " ", with: "%20")
        
        return text
    }
    
    static func cleanSummary(_ textToClean: String) -> String {
        var text:String = textToClean
        text = text.replacingOccurrences(of: "<a>", with: "")
        text = text.replacingOccurrences(of: "<b>", with: "\n")
        text = text.replacingOccurrences(of: "<p>", with: "")
        text = text.replacingOccurrences(of: "<i>", with: "")
        text = text.replacingOccurrences(of: "</a>", with: "")
        text = text.replacingOccurrences(of: "</b>", with: "\n")
        text = text.replacingOccurrences(of: "</p>", with: "")
        text = text.replacingOccurrences(of: "</i>", with: "")
        
        return text
    }
    
}
