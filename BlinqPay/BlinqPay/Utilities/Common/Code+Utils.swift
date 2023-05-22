//
//  Code+Utils.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import Foundation
import UIKit
import RxSwift

let preference = PreferenceImpl()

public func runAfter(_ delay: Double = 0.5, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
        action()
    }
}

public func runOnMainThread(action: @escaping () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}

public func runOnBackgroundThread(action: @escaping () -> Void) {
    DispatchQueue.global().async {
        action()
    }
}

public func animateView(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }, codeToAnimate: @escaping () -> Void) {
    UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        codeToAnimate()
    }, completion: completion)
}

public func randomString(length: Int = 11) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

public extension Set {
    var toArray: [Element] {
        return Array(self)
    }
}

public extension Collection {
    func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

public extension String {
    
    var isNumber: Bool {
        rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var isNotNumber: Bool { !isNumber }
    
    func chunkFormatted(withChunkSize chunkSize: Int = 4, withSeparator separator: Character = " ") -> String {
        return self.filter { $0 != separator }.chunk(n: chunkSize).map{ String($0) }.joined(separator: String(separator))
    }
    
    func formatWith234() -> String {
        var value = self
        value.replaceSubrange(value.startIndex...value.startIndex, with: "+234")
        return value
    }
    
    var remove234: String {
        return self.replacingOccurrences(of: "+234", with: "0")
    }
    
    func removePhoneCode() -> String {
        if hasPrefix("234") {
            return replaceFirstOccurrence(of: "234", with: "")
        }
        else if hasPrefix("233") {
            return replaceFirstOccurrence(of: "233", with: "")
        }
        else if hasPrefix("254") {
            return replaceFirstOccurrence(of: "254", with: "")
        }
        else if hasPrefix("225") {
            return replaceFirstOccurrence(of: "225", with: "")
        }
        else if hasPrefix("256") {
            return replaceFirstOccurrence(of: "256", with: "")
        }
        else {
            return replacingOccurrences(of: "+234", with: "").replacingOccurrences(of: "+233", with: "").replacingOccurrences(of: "+254", with: "").replacingOccurrences(of: "+225", with: "").replacingOccurrences(of: "+256", with: "")
        }
    }
    
    func replaceFirstOccurrence(of target: String, with replaceString: String) -> String {
        if let range = range(of: target) {
            return replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
    
    var orDash: String {
        return self.isEmpty ? "-" : self
    }
    
    var orEmpty: String {
        return self.isEmpty ? "" : self
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = self
    }
    
    var int: Int? { Int(self) }
    
    var float: Float? { Float(self) }
    
    var double: Double? { Double(self) }
    
    var dropFirstIfZero: String {
        if first == "0" {
            return String(dropFirst())
        }
        return self
    }
    
    var jsonBundleURL: URL? { Bundle.main.url(forResource: self, withExtension: "json") }
    
    func insensitiveEquals(_ other: String) -> Bool {
        localizedCaseInsensitiveCompare(other) == .orderedSame
    }
    
    func insensitiveNotEquals(_ other: String) -> Bool {
        !insensitiveEquals(other)
    }
    
    func insensitiveContains(_ other: String) -> Bool {
        localizedCaseInsensitiveContains(other)
    }
    
    var currencySignRemoved: String {
        replacingOccurrences(of: "Constants.getCurrency()", with: "")
    }
    
    var amountSanitized: String {
        commasRemoved.currencySignRemoved
    }
    
    func amountSanitized(symbol: String) -> String {
        spacesRemoved.commasRemoved.replacingOccurrences(of: symbol, with: "")
    }
    
    var whitespacesAndBNewlinesRemoved: String { trimmingCharacters(in: .whitespacesAndNewlines) }
    
    var digitsRemoved: String { components(separatedBy: .decimalDigits).joined() }
    
    var whitespacesAndNewlinesRemoved: String { trimmingCharacters(in: .whitespacesAndNewlines).spacesRemoved }
    
    var spacesRemoved: String { replacingOccurrences(of: " ", with: "") }
    
    var dashesRemoved: String { replacingOccurrences(of: "-", with: "") }
    
    var commasRemoved: String { replacingOccurrences(of: ",", with: "") }
    
}

public extension URL {
    func mapTo<T: Codable>(_ type: T.Type) -> T? {
        try? JSONDecoder().decode(type, from: Data(contentsOf: self))
    }
}

public func restrictTextfieldToDigitsWithMaximumLength(textField: UITextField, range: NSRange, string: String, maxLength: Int) -> Bool {
    // get the current text, or use an empty string if the failed
    let currentText = textField.text ?? ""

    // attempt to read the range they are trying to change, or exit if we can't
    guard let stringRange = Range(range, in: currentText) else { return false }

    // add their new text to the existing text
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    
    //  make sure the result is under `maxLength` characters and remove non-numerics and compare with original string
    return string == string.filter("0123456789".contains) && updatedText.count <= maxLength
    
}

//MARK: - Substrings
public extension String {
    
    subscript (start: Int, end: Int) -> Substring {
        let startPos = index(startIndex, offsetBy: start)
        let endPos: String.Index
        if end > 0 {
            endPos = index(startIndex, offsetBy: end)
        } else {
            endPos = index(endIndex, offsetBy: end)
        }
        return self[startPos...endPos]
    }
    
    subscript (pos: Int) -> Character {
        if pos > 0 {
            return self[index(startIndex, offsetBy: pos)]
            
        }
        return self[index(endIndex, offsetBy: pos)]
    }
    
}

//MARK: - Current Date Year and Month

public func currentYear() -> String {
    let date = Date()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: date) // gets current year (i.e. 2017)
    
    return "\(currentYear)"
}

public func currentMonth() -> String {
    let date = Date()
    let calendar = Calendar.current
    let currentMonth = calendar.component(.month, from: date) // gets current month (i.e. 10)
    
    return "\(currentMonth)"
}

public func currentYearFirstTwoDigits() -> Int {
    return Int(currentYear()[0,1])!
}

public func currentYearLastTwoDigits() -> Int {
    return Int(currentYear()[2,3])!
}

public extension Collection where Iterator.Element == Int {
    var seatsString: String {
        return String(describing: self.compactMap { $0 }).replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
    }
}

public extension Data {
    var mbSize: Float {
        return Float(Float(self.count) / 1048576.0)
    }
}

public extension UIApplication {

  func setRootViewController(_ vc : UIViewController){
      self.windows.first?.rootViewController = vc
      self.windows.first?.makeKeyAndVisible()
    }
}

public extension Sequence {
    func distinctBy<A: Hashable>(by selector: (Iterator.Element) -> A) -> [Iterator.Element] {
        var set: Set<A> = []
        var list: [Iterator.Element] = []

        forEach { e in
            let key = selector(e)
            if set.insert(key).inserted {
                list.append(e)
            }
        }

        return list
    }
}

extension Collection {
    
    var asObservable: Observable<[Element]> { Observable.just(self as! [Self.Element]) }
    
    var isNotEmpty: Bool { !self.isEmpty }
    
    func countEquals(_ number: Int) -> Bool { count == number }
    
    func countNotEqual(to number: Int) -> Bool { count != number }
    
    func countGreaterThan(_ number: Int) -> Bool { count > number }
    
    func countGreaterThanOrEquals(_ number: Int) -> Bool { count >= number }
    
    func countLessThan(_ number: Int) -> Bool { count < number }
    
    func countLessThanOrEquals(_ number: Int) -> Bool { count <= number }
}


public extension Optional {
    var isNil : Bool {
        self == nil
    }
    
    var isNotNil : Bool {
        self != nil
    }
}

extension Optional where Wrapped == [Array<Any>] {
    var orEmptyList: [Any] { isNil ? [] : self! }
}

extension Optional where Wrapped == Int {
    var orZero: Int { isNil ? 0 : self! }
    
    var described: String {
        String(describing: self)
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double { isNil ? 0.double : self! }
    
    var described: String {
        String(describing: self)
    }
}

extension Optional where Wrapped == Number {
    var orZero: Int { (isNil ? 0 : self!) as! Int }
    
    var described: String {
        String(describing: self)
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        self?.isEmpty ?? true ? "" : self!
    }
    
    var described: String {
        String(describing: self)
    }
}

public extension Decodable {
    ///Maps JSON String to actual Decodable Object
    ///throws an exception if mapping fails
    static func mapFrom(jsonString: String) throws -> Self? {
        
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Self.self, from: Data(jsonString.utf8))
    }
}

public extension Encodable {
    
    var jsonString: String {
        do {
            return String(data: try JSONEncoder().encode(self), encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
    var prettyPrinted: String {
        let responseData = try! JSONSerialization.data(withJSONObject: self.dictionary, options: .prettyPrinted)
        return String(data: responseData, encoding: .utf8)!
    }
    
    var dictionaryValue: Any {
        do {
            let data = try JSONEncoder().encode(self)
            //return String(data: data , encoding: .utf8) ?? ""
            return try JSONSerialization.jsonObject(with: data)
        } catch {
            return ""
        }
    }
    
    var dictionaryArray: [[String: Any]] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [[String: Any]] ?? [[:]]
    }
    
}

extension Dictionary {
    mutating func merge<K, V>(_ dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
    
    init(_ slice: Slice<Dictionary>) {
        self = [:]
        
        for (key, value) in slice {
            self[key] = value
        }
    }
    
    func containKey(_ key: Key) -> Bool {
        return index(forKey: key) == nil ? false : true
    }
    
}

func generateHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

var notchHeight: CGFloat { UIApplication.shared.statusBarFrame.height }

func _print(_ message: Any, _ messageType: ToastType = .error, isJsonResponse: Bool = false) {
    #if DEV || STAGING
    switch messageType {
    case .error:
        print("🔴🔴🔴 " + String(describing: message))
    case .success:
        if isJsonResponse {
            print("Request Response: 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢")
            print(message)
        } else {
            print("🟢🟢🟢 " + String(describing: message))
        }
    }
    #endif
}

extension Array where Element: Equatable {
    func doesNotContain(_ element: Element) -> Bool {
        return !contains(element)
    }
}

func _animate(duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: duration, animations: {
        completion?()
    })
}

extension Dictionary {
    mutating func merge(_ dict: [Key: Value]) -> Self {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
        return self
    }
}

func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

extension NSObject {

    /// Returns class name stripped from module name.
    class var className: String {
        let namespaceClassName = String(describing: self)
        return namespaceClassName.components(separatedBy: ".").last!
    }
}
