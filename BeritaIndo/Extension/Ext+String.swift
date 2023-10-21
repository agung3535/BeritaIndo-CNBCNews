//
//  Ext+String.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 21/10/23.
//

import Foundation


extension String {
    func convertISODateToMyFormatDate(localeIdentifier: String) -> String? {
           let isoDateFormatter = DateFormatter()
           isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
           isoDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

           if let date = isoDateFormatter.date(from: self) {
               let outputDateFormatter = DateFormatter()
               outputDateFormatter.dateFormat = "EEEE, d MMM yyyy, HH:MM a"
               outputDateFormatter.locale = Locale(identifier: localeIdentifier)
               return outputDateFormatter.string(from: date)
           } else {
               return nil
           }
       }
}

