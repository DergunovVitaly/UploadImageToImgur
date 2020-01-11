//
//  Bundle+Ext.swift
//  
//
//  Created by Vitalii Derhunov on 25.10.2019.
//  
//

import Foundation

extension Bundle {
    var appVersion: String {
        let version = object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0"
        let build = object(forInfoDictionaryKey: "CFBundleVersion") ?? "0"
        return "\(version)(\(build))"
    }
}
