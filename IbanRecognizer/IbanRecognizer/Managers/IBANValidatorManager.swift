//
//  IBANValidatorManager.swift
//  IbanRecognizer
//
//  Created by Hamza on 29/11/2024.
//
import AVFoundation

protocol IBANValidator {
    func validate(iban: String) -> Bool
}

class IBANValidatorManager: NSObject, IBANValidator {
    func validate(iban: String) -> Bool {
        // Validate the IBAN format
        return iban.trim().isValidIban()
    }
}
