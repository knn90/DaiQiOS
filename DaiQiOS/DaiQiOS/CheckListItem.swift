import SwiftUI

struct ChecklistItem: Identifiable, Hashable, Codable {
    var title: String
    var description: String
    var isChecked: Bool = false
    var id: String {
        return title + description
    }
}
