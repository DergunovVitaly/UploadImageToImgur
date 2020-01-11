//
//  Date+Ext.swift
//  HomeNotes
//
//  Created by Vitalii Derhunov on 25.10.2019.
//  
//

import Foundation

private struct StaticVariables {
    private static let serverFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSz"
    
    private static let dateFormatter = DateFormatter()

    static func serverFormatter() -> DateFormatter {
        dateFormatter.dateFormat = serverFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
}

extension Date {

    static func dateFromServerString(_ string: String) -> Date? {
        return StaticVariables.serverFormatter().date(from: string)
    }

    var dateString: String {
        return StaticVariables.serverFormatter().string(from: self)
    }
}
