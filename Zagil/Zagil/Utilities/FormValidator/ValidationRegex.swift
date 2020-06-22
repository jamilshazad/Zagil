//
//  ValidationRegex.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 23/01/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum ValidationRegex {
    
    case email
    case name
    case username
    case password
    case phone
    case usstates
    case securitycode
    case alphanumeric
    case alphanumaricWithWhitespace
    case pincode
    case emailAndUsername
    case custom(regex: String)
    case number
    case space
    case alphabets
    case accent
    case special
    case compound([ValidationRegex])
    
    
    // MARK: - Properties
    
    private var regex: String {
        switch self {
        case .email: return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case .name: return "^[-'a-zA-Z ]+$"
        case .username: return "^(?=.{6,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$"
        case .password: return "^(?=.*[A-Za-z])(?=.*[^A-Za-z]).{8,20}$"
        case .phone: return "^((\\+)|(00))[0-9]{6,14}$"
        case .usstates: return "^(?:(A[AEKLPRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$"
        case .securitycode: return "^[0-9]{3,4}$"
        case .alphanumeric: return "^[a-zA-Z0-9]*$"
        case .alphanumaricWithWhitespace: return "^[a-zA-Z0-9 ]*$"
        case .pincode: return "^[0-9*#]*$"
        case .emailAndUsername: return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}|^[a-zA-Z][a-zA-Z\\s]*$"
        case .custom(let regex): return regex
        case .number: return "^[0-9]*$"
        case .space: return "^[ ]*$"
        case .alphabets: return "^[a-zA-Z]*$"
        case .accent: return "^[èéêëēėęÈÉÊËĒĖĘÿŸûüùúūÛÜÙÚŪîïíīįìÎÏÍĪĮÌôöòóœøōõÔÖÒÓŒØŌÕàáâäæãåāÀÁÂÄÆÃÅĀßśšŚŠłŁžźżŽŹŻçćčÇĆČñńÑŃ]*$"
        case .special: return "^[!_\"&‘’'-.]*$"
        case .compound(let regexes):
            var regex = "^["
            regexes.forEach { regex += $0.regex.replacingOccurrences(of: "^[", with: "").replacingOccurrences(of: "]*$", with: "") }
            regex += "]*$"
            return regex
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email, .username, .emailAndUsername:
            return .emailAddress
        case .phone, .securitycode, .pincode:
            return .numberPad
        default:
            return .default
        }
    }
    
    
    // MARK: - Public Methods
    
    public func validate(string: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string)
    }
    
}
