//
//  NDError.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 30.03.2021.
//

import Foundation

enum NDError: Error {
    case unableToComplete
    case wrongRequest(statusCode: Int)
    case wrongData
    case noUrl
}
