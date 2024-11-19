// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Recommencer
  internal static let ibanSheetViewRetry = L10n.tr("Localizable", "_iban_sheet_view_retry", fallback: "Recommencer")
  /// L'IBAN du bénéficiaire a été scanné
  internal static let ibanSheetViewTitle = L10n.tr("Localizable", "_iban_sheet_view_title", fallback: "L'IBAN du bénéficiaire a été scanné")
  /// Valider
  internal static let ibanSheetViewValidate = L10n.tr("Localizable", "_iban_sheet_view_validate", fallback: "Valider")
  /// Pensez à le vérifier avant de valider:
  internal static let ibanSheetViewValidateTitle = L10n.tr("Localizable", "_iban_sheet_view_validate_title", fallback: "Pensez à le vérifier avant de valider:")
  /// Localizable.strings
  ///   IbanRecognizer
  /// 
  ///   Created by soua hamza on 14/11/2024.
  internal static let scannerViewNavigationTitle = L10n.tr("Localizable", "_scanner_view_navigation_title", fallback: "Scanner Votre IBAN")
  /// Comptes
  internal static let tabViewItem1 = L10n.tr("Localizable", "_tab_view_item_1", fallback: "Comptes")
  /// Virements
  internal static let tabViewItem2 = L10n.tr("Localizable", "_tab_view_item_2", fallback: "Virements")
  /// Aide
  internal static let tabViewItem3 = L10n.tr("Localizable", "_tab_view_item_3", fallback: "Aide")
  /// Plus
  internal static let tabViewItem4 = L10n.tr("Localizable", "_tab_view_item_4", fallback: "Plus")
  /// FR76 XXXX
  internal static let transactionViewIbanPlaceholder = L10n.tr("Localizable", "_transaction_view_iban_placeholder", fallback: "FR76 XXXX")
  /// Importer
  internal static let transactionViewImportButton = L10n.tr("Localizable", "_transaction_view_import_button", fallback: "Importer")
  /// Ajouter un bénéficiaire
  internal static let transactionViewNavigationTitle = L10n.tr("Localizable", "_transaction_view_navigation_title", fallback: "Ajouter un bénéficiaire")
  /// Scanner
  internal static let transactionViewScannerButton = L10n.tr("Localizable", "_transaction_view_scanner_button", fallback: "Scanner")
  /// Scannez, importez ou saisissez l'IBAN
  internal static let transactionViewText = L10n.tr("Localizable", "_transaction_view_text", fallback: "Scannez, importez ou saisissez l'IBAN")
  /// account View
  internal static let accountViewText = L10n.tr("Localizable", "account_view_text", fallback: "account View")
  /// help View
  internal static let helpViewText = L10n.tr("Localizable", "help_view_text", fallback: "help View")
  /// more View
  internal static let moreViewText = L10n.tr("Localizable", "more_view_text", fallback: "more View")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
