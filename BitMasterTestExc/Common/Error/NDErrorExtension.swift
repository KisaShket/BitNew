//
//  NDErrorExtension.swift
//  BitMasterTestExc
//
//  Created by Kisa Shket on 30.03.2021.
//

import Foundation

extension NDError : LocalizedError {
    var errorDescription: String?{
        
        switch self {
        
        case .unableToComplete:
            return NSLocalizedString(
                "Unable to complete your request. Please check your internet connection.", comment: "")
        case .wrongRequest(statusCode: let statusCode):
            return NSLocalizedString(
                "The call failed with HTTP code: \(statusCode)", comment: "")
        case .wrongData:
            return NSLocalizedString(
                "The data recieved from the server was wrong. Please try again." , comment: "")
        case .noUrl:
            return NSLocalizedString(
                "There is wrong url or url not exist.", comment: "")
        }
    }
}
