import Foundation
import UIKit

extension String {
    
    func isBefore(_ character: Character) -> Bool {
        guard let index = self.firstIndex(of: character) else { return false }
        let char = self.index(before: index)
        switch self[char] {
        case "а": return true
        case "е": return true
        case "ё": return true
        case "и": return true
        case "о": return true
        case "у": return true
        case "ь": return true
        case "ъ": return true
        case "э": return true
        case "ю": return true
        case "я": return true
        case "А": return true
        case "Е": return true
        case "Ё": return true
        case "И": return true
        case "О": return true
        case "У": return true
        case "Э": return true
        case "Ю": return true
        case "Я": return true
        default: return false
        }
    }
    
    func convert() -> String {
        var convertString: String = ""
        for i in self {
            switch i {
            case "а": convertString.append("a")
            case "б": convertString.append("b")
            case "в": convertString.append("v")
            case "г": convertString.append("g")
            case "д": convertString.append("d")
            case "е": if "е" == self.first || self.isBefore("е"){
                convertString.append("ye")
            } else {
                convertString.append("e")
            }
            case "ё": if "ё" == self.first || self.isBefore("ё") {
                convertString.append("yo")
            } else {
                convertString.append("o")
            }
            case "ж": convertString.append("zh")
            case "з": convertString.append("z")
            case "и": convertString.append("i")
            case "й": convertString.append("y")
            case "к": convertString.append("k")
            case "л": convertString.append("l")
            case "м": convertString.append("m")
            case "н": convertString.append("n")
            case "о": convertString.append("o")
            case "п": convertString.append("p")
            case "р": convertString.append("r")
            case "с": convertString.append("s")
            case "т": convertString.append("t")
            case "у": convertString.append("u")
            case "ф": convertString.append("f")
            case "х": convertString.append("h")
            case "ц": convertString.append("ts")
            case "ш": convertString.append("sh")
            case "щ": convertString.append("sch")
            case "ь": convertString.append("'")
            case "э": convertString.append("e")
            case "ю": if "ю" == self.first || self.isBefore("ю") {
                convertString.append("yu")
            } else {
                convertString.append("u")
            }
            case "я": if "я" == self.first || self.isBefore("я") {
                convertString.append("ya")
            } else {
                convertString.append("a")
            }
            case "А": convertString.append("A")
            case "Б": convertString.append("B")
            case "В": convertString.append("V")
            case "Г": convertString.append("G")
            case "Д": convertString.append("D")
            case "Е": convertString.append("Ye")
            case "Ё": convertString.append("Yo")
            case "Ж": convertString.append("Zh")
            case "З": convertString.append("Z")
            case "И": convertString.append("I")
            case "Й": convertString.append("Y")
            case "К": convertString.append("K")
            case "Л": convertString.append("L")
            case "М": convertString.append("M")
            case "Н": convertString.append("N")
            case "О": convertString.append("O")
            case "П": convertString.append("P")
            case "Р": convertString.append("R")
            case "С": convertString.append("S")
            case "Т": convertString.append("T")
            case "У": convertString.append("U")
            case "Ф": convertString.append("F")
            case "Х": convertString.append("H")
            case "Ц": convertString.append("Ts")
            case "Ш": convertString.append("Sh")
            case "Щ": convertString.append("Sch")
            case "Э": convertString.append("E")
            case "Ю": convertString.append("Yu")
            case "Я": convertString.append("Ya")
            case " ": convertString.append("-")
            case "-": convertString.append("-")
            default: convertString.append("")
            }
        }
        return convertString
    }
    
    func withFirstUppercase() -> String {
        let first = self.first?.uppercased()
        let newWord = first! + self.dropFirst()
        return newWord
    }
}

extension Int32 {
    func toDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU_ru")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm eee d MMMM"
        return dateFormatter.string(from: date)
    }
    
    func toShotDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU_ru")
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    }
    
    func toTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RU_ru")
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

extension UILabel {
    func textWithImage(imageName: String, text: String) {
        let attachement = NSTextAttachment()
        attachement.image = UIImage(named: imageName)
        let textImage = NSAttributedString(attachment: attachement)
        
        let labelText = NSMutableAttributedString(string: text)
        labelText.insert(textImage, at: 0)
        self.attributedText = labelText
    }
}
