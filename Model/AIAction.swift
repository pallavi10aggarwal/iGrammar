
import SwiftUI

enum AIAction {
    case grammar
    case paraphrase
    case improve

    func prompt(for text: String) -> String {
        switch self {
        case .grammar:
            return "Correct grammar and spelling:\n\(text)"
        case .paraphrase:
            return "Paraphrase this text in simple English:\n\(text)"
        case .improve:
            return "Here is an improved version: \(text)"
            
        }
    }
}
