public enum Disk: Equatable {
    case dark
    case light
}

extension Disk {
    public var flipped: Disk {
        switch self {
        case .dark: return .light
        case .light: return .dark
        }
    }
    
    public mutating func flip() {
        self = flipped
    }
}
