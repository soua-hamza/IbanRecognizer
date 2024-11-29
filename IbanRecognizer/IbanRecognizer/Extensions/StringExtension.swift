//
//  StringExtension.swift
//  IbanRecognizer
//
//  Created by HAMZA on 17/11/2024.
//

import Foundation

protocol IbanValidation {
    func isValidIban() -> Bool
    func trim() -> String
}

extension String: IbanValidation {
    func isValidIban() -> Bool {
        let regex = "^FR\\d{12}[0-9A-Z]{11}\\d{2}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    func trim() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: " ", with: "")
    }
}
