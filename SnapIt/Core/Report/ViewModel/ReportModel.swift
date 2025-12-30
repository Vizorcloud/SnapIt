//
//  Photo.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/22/24.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

struct Report: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = "" // This will hold the URL for loading the image
    var postedOn = Date()
    var latitude = 0.0
    var longitude = 0.0
    
    var dictionary: [String: Any] {
        return [UserReport.CodingKeys.imageURLString.rawValue: imageURLString, UserReport.CodingKeys.dateCreated.rawValue: Timestamp(date: Date()), UserReport.CodingKeys.status.rawValue: "Unreviewed", UserReport.CodingKeys.latitude.rawValue: latitude, UserReport.CodingKeys.longitude.rawValue: longitude]
    }
}
