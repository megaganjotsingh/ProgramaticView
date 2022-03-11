//
//  String+Extensions.swift
//  Ed-fundo
//
//  Created by Abhishek on 29/07/21.
//

import Foundation
import UIKit

#if DEBUG
    func printDebug(_ items: Any...) {
        print(items)
    }
#endif

extension String {
    /**
     - parameters:
     - path: The path to append to current string
     
     - returns:
     The complete path string
     */
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    /**
     - returns:
     The masked string
     */
    var masked: String {
        return String(repeating: "X", count: max(0, count-3)) + String(suffix(3))
    }
    
    /**
     - returns:
     The localizedString
     */
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /**
     - returns:
     The string by removing extra white spaces
     */
    var stringByRemovingExtraWhitespaces: String {
        
        let components = self.components(separatedBy: .whitespaces).filter { (element) -> Bool in
            return !element.isEmpty
        }
        
        return components.joined(separator: " ")
    }
    
    var stringByRemovingExtraLines: String{
        let components = self.components(separatedBy: .newlines).filter { (element) -> Bool in
            return !element.isEmpty
        }
        return components.joined(separator: "\n")
    }
    
    //right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
            , leftRange.upperBound <= rightRange.lowerBound
        else { return nil }
        
        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }
}

extension String {
    
    /**
     - returns:
     The base64Encoded string
     */
    var base64Encoded:String {
        
        return Data(self.utf8).base64EncodedString()
    }
    
    /**
     - returns:
     The string decoded from base64Encoded string
     */
    var base64Decoded:String? {
        
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /**
     - returns:
     The string decoded from html tags
     */
    var decodeHtml: String? {
        
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        let str1 = str.replacingOccurrences(of: "&lt;", with: "<")
        let str2 = str1.replacingOccurrences(of: "&gt;", with: ">")
        let str3 = str2.replacingOccurrences(of: "&amp;nbsp;", with: " ")
        let str4 = str3.replacingOccurrences(of: "&amp;rsquo;", with: "'")
        let str5 = str4.replacingOccurrences(of: "&amp;ldquo;", with: "\"")
        let str6 = str5.replacingOccurrences(of: "&amp;rdquo;", with: "\"")
        
        
        return str6
    }
    
    /**
     - returns:
     The string excluding trailing white spaces
     */
    public func trimTrailingWhitespace() -> String {
        if let trailingWs = self.range(of: "\\s+$", options: .regularExpression) {
            return self.replacingCharacters(in: trailingWs, with: "")
        } else {
            return self
        }
    }
    
    /**
     - returns:
     The boolean value if string contains emoji
     */
    var containsEmoji: Bool {
        
        return !unicodeScalars.filter { $0.isEmoji }.isEmpty
    }
    
    /**
     - returns:
     The date(in current timezone) from string(in UTC)
     */
    var getDateFromString: Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let dt = dateFormatter.date(from: self) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let currentLocaleDate = dateFormatter.string(from: dt)
            return dateFormatter.date(from: currentLocaleDate)
        }
        return nil
    }
    
    
    
    /**
     - returns:
     The localized string
     */
    var localized : String {
        return localizedString(lang: "en")
    }
    
    /**
     
     - parameters:
     - lang: The language key for which localization is to be fetched
     
     - returns:
     The localized string
     */
    private func localizedString(lang:String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    /**
     - returns:
     Dictionary of type [String:Any]? from json string
     */
    var convertToDictionary: [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                printDebug(error.localizedDescription)
            }
        }
        return nil
    }
    
    var convertToArray: [[String: Any]]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                printDebug(error.localizedDescription)
            }
        }
        return nil
    }
    
    /**
     - parameters:
     - string_to_color: String to apply color attribute
     - color: The color to apply
     
     - returns:
     Resultant attributed string
     */
    func attributeStringColor(string_to_color : String , color : UIColor) -> NSAttributedString{
        let range = (self as NSString).range(of: string_to_color)
        let attributedString = NSMutableAttributedString(string:self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        return attributedString
    }
    
    /**
     - parameters:
     - string_to_color: Array of string to apply color attribute
     - color: Array of color to apply
     
     - returns:
     Resultant attributed string
     */
    func multipleAttributeStringColor(string_to_color : [String] , color : [UIColor]) -> NSAttributedString{
        
        let attributedString = NSMutableAttributedString(string: self)
        
        for str in string_to_color{
            let idx = string_to_color.firstIndex(of: str)
            let range = (self as NSString).range(of: str)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color[idx!] , range: range)
        }
        return attributedString
    }
    
    /**
     - returns:
     String by removing leading trailing white spaces
     */
    var stringByRemovingLeadingTrailingWhitespaces : String {
        let spaceSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: spaceSet)
    }
    
    public func replacing(_ substring: String, with newString: String) -> String {
        return replacingOccurrences(of: substring, with: newString)
    }
    
    func matches(pattern: String) -> Bool {
        return range(of: pattern,
                     options: String.CompareOptions.regularExpression,
                     range: nil, locale: nil) != nil
    }
    
    
    /// SwifterSwift: Check if string contains one or more letters.
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// SwifterSwift: Check if string contains one or more numbers.
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// SwifterSwift: Check if string contains only letters.
    public var isAlphabetic: Bool {
        return hasLetters && !hasNumbers
    }
    
    public var isAlphaNumeric : Bool{
        return isAlphabetic || isNumeric
    }
    
    /// SwifterSwift: Check if string contains at least one letter and one number.
    
    
    /// SwifterSwift: Check if string is valid email format.
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    public var isUsername : Bool {
        return matches(pattern: "^([A-Za-z_][A-Za-z0-9_.]*){0,30}$")
    }
    
    /// SwifterSwift: Check if string is a valid URL.
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// SwifterSwift: Check if string is a valid schemed URL.
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme != nil
    }
    
    /// SwifterSwift: Check if string is a valid https URL.
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "https"
    }
    
    /// SwifterSwift: Check if string is a valid http URL.
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return url.scheme == "http"
    }
    
    /// SwifterSwift: Check if string contains only numbers.
    public var isNumeric: Bool {
        return !(isEmpty) && allSatisfy { $0.isNumber }
        //        return  !hasLetters && hasNumbers
    }
    
    
    
    /// SwifterSwift: Latinized string.
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    
    /// SwifterSwift: Array of strings separated by new lines.
    public var lines: [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    /// SwifterSwift: Bool value from string (if applicable).
    public var bool: Bool? {
        let selfLowercased = trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        }
        return nil
    }
    
    /// SwifterSwift: Date object from "yyyy-MM-dd" formatted string
    public var date: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    public var dateTime: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }
    
    /// SwifterSwift: Double value from string (if applicable).
    public var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }
    
    public var cgFloat: CGFloat? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? CGFloat
    }
    
    /// SwifterSwift: Float value from string (if applicable).
    public var float: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }
    
    /// SwifterSwift: Float32 value from string (if applicable).
    public var float32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }
    
    /// SwifterSwift: Float64 value from string (if applicable).
    public var float64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }
    
    /// SwifterSwift: Integer value from string (if applicable).
    public var intValue: Int {
        return Int(self) ?? 0
    }
    
    /// SwifterSwift: Int16 value from string (if applicable).
    public var int16Value: Int16 {
        return Int16(self) ?? 0
    }
    
    /// SwifterSwift: Int32 value from string (if applicable).
    public var int32Value: Int32 {
        return Int32(self) ?? 0
    }
    
    /// SwifterSwift: Int64 value from string (if applicable).
    public var int64Value: Int64 {
        return Int64(self) ?? 0
    }
    
    /// SwifterSwift: Int8 value from string (if applicable).
    public var int8Value: Int8 {
        return Int8(self) ?? 0
    }
    
    /// SwifterSwift: URL from string (if applicable).
    public var url: URL? {
        return URL(string: self)
    }
    
    /// SwifterSwift: String with no spaces or new lines in beginning and end.
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// SwifterSwift: Array with unicodes for all characters in a string.
    public var unicodeArray: [Int] {
        return unicodeScalars.map({$0.hashValue})
    }
    
    /// SwifterSwift: Readable string from a URL string.
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// SwifterSwift: URL escaped string.
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func isMatching(_ string: String) -> Bool {
        return self == string
    }
    
    /// SwifterSwift: String without spaces and new lines.
    public var withoutSpacesAndNewLines: String {
        return replacing(" ", with: "").replacing("\n", with: "")
    }
    
    var doubleValue: Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func checkValidity(_ validityExression : ValidityExression) -> Bool {
        
        let regEx = validityExression.rawValue
        
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return test.evaluate(with: self)
    }
    
    func checkInvalidity(_ validityExression : ValidityExression) -> Bool {
        
        return !self.checkValidity(validityExression)
    }
    
    var hexadecimal: Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        guard data.count > 0 else { return nil }
        return data
    }
    
    func matchesForRegexInText(regex: String, text: String) -> [String] {
    do {

        let regex = try NSRegularExpression(pattern: regex, options: [])
        let nsString = text as NSString
        let results = regex.matches(in: text,
                                            options: [], range: NSMakeRange(0, nsString.length))
        return results.map { nsString.substring(with: $0.range)}

    } catch let error as NSError {
        printDebug("invalid regex: \(error.localizedDescription)")
        return []
    }}
    
    var path: String? {
        return Bundle.main.path(forResource: self, ofType: nil)
    }
}

//MARK: ValidityExression : String
enum ValidityExression : String {
    case Username = "^(?=.*[A-Za-z0-9])[A-Za-z0-9_.]{5,30}$"
    case Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,50}"
    case MobileNumber = "^[0-9]{6,16}$"
    case Password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$^=!%*?&#])[A-Za-z\\dd$@^=$!%*?&#]{8,}"
    case FirstName = "^[a-zA-Z ]{2,15}"
//    case LastName = "^[a-zA-Z ]{2,15}"
    case completeName = "^[a-zA-Z]{2,25}"
    case FullName = "^[a-zA-Z ]{2,30}"
    case AccountNumber = "^[0-9]{9,16}"
    case UsernameInput = "^(?=.*[A-Za-z0-9])[A-Za-z0-9_.]{1,30}$"
    case URL = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
}

//MARK: UnicodeScalar
extension UnicodeScalar {
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
             0x1F300...0x1F5FF, // Misc Symbols and Pictographs
             0x1F680...0x1F6FF, // Transport and Map
             0x1F1E6...0x1F1FF, // Regional country flags
             0x2600...0x26FF, // Misc symbols
             0x2700...0x27BF, // Dingbats
             0xE0020...0xE007F, // Tags
             0xFE00...0xFE0F, // Variation Selectors
             0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
             0x1F018...0x1F270, // Various asian characters
             0x238C...0x2454, // Misc items
             0x20D0...0x20FF: // Combining Diacritical Marks for Symbols
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}

extension String {
    var initials: String {
        var finalString = String()
        var words = components(separatedBy: .whitespacesAndNewlines)
        
        if let firstCharacter = words.first?.first {
            finalString.append(String(firstCharacter))
            words.removeFirst()
        }
        
        if let lastCharacter = words.last?.first {
            finalString.append(String(lastCharacter))
        }
        
        return finalString.uppercased()
    }
    func size(withConstrainedWidth width: CGFloat, using font: UIFont) -> CGSize{
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.size
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size
    }
    
    func width(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let size = self.size(withConstrainedWidth: width, using: font)
        return size.width
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let size = self.size(withConstrainedWidth: width, using: font)
        return size.height
    }
    
    
    func getNoOfLinesWithConstrainedWidth(width: CGFloat, font: UIFont)->Int{
        let maxSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let text = (self) as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    
    
    func height(constraintedWidth width: CGFloat, font: UIFont , line:Int = 0) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = line
        label.text = self
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
    
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    var unescapeString : String {
        return replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
    }
    
    func indexInt(of str: String) -> Int? {
        
        if let range: Range<String.Index> = range(of: str) {
            let index: Int = distance(from: startIndex, to: range.lowerBound)
            return index
        } else {
            return nil
        }
    }
    
    func capitalFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil,length:Int) -> [NSRange] {
        var ranges: [NSRange] = []
        do {
            let regex = try NSRegularExpression(pattern: substring)
            for match in regex.matches(in: self, options: [], range: NSRange(location: 0, length: length)) {
                ranges.append(match.range)
            }
        } catch {
            printDebug(error)
        }
        return ranges
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let startPos = self.distance(from: self.startIndex, to: range.lowerBound)
        let endPos = self.distance(from: self.startIndex, to: range.upperBound)
        return NSMakeRange(startPos, endPos - startPos)
    }
    
    func getAllMatches(text:String)-> [NSTextCheckingResult]{
        let pattern = "\(text)\\b"
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results
        } catch {
            printDebug(error)
        }
        return []
    }
    
//    func hasWhitespace(with index: Int) -> Bool {
//        if index < 1 { return false }
//        return self[index - 1] == " " || self[index] == " "
//    }
//    
//    func checkWhitespace(with index: Int, string: String) -> Bool {
//        if self.hasWhitespace(with: index) && string.contains(" ") {
//            return true
//        } else if self.isEmpty && string.contains(" ") {
//            return true
//        } else {
//            return false
//        }
//    }
}

extension StringProtocol {
    func nsRange(ofString string : String)->NSRange{
        guard let range = self.range(of: string) else {return NSRange.init()}
        return .init(range, in: self)
    }
}

extension String {
    func textToImage() -> UIImage? {
        let nsString = (self as NSString)
        let font = UIFont.systemFont(ofSize: 35)
        let stringAttributes = [NSAttributedString.Key.font: font]
        let imageSize = nsString.size(withAttributes: stringAttributes)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        UIColor.clear.set()
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize))
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
