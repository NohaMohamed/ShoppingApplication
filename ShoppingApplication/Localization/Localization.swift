//
//  Localization.swift
//  FreeNow
//
//  Created by Omar Tarek on 4/3/21.
//

import Foundation

struct Localization {
    
    enum LocalizationKey: String {
        
        case errorMessageGeneric = "error_message_generic"
        case errorMessageCanNotSendRequest = "error_message_can_not_send_request"
        case errorMessageCanNotReadData = "error_message_can_not_read_data"
    }
    
    static func string(for key: LocalizationKey) -> String {
        NSLocalizedString(key.rawValue, comment: "")
    }
}
