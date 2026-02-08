import Foundation
import SwiftUI

struct FamilyMember: Identifiable, Codable {
    let id: String
    var name: String
    var role: String
    var avatar: String
    var usedMinutes: Int
    var limitMinutes: Int
    var isPaused: Bool
    var topApps: [AppUsage]
    
    var progress: Double {
        return min(Double(usedMinutes) / Double(limitMinutes), 1.0)
    }
    
    var remainingTime: String {
        let diff = limitMinutes - usedMinutes
        if diff <= 0 { return "Limit Reached" }
        let h = diff / 60
        let m = diff % 60
        return h > 0 ? "\(h)h \(m)m left" : "\(m)m left"
    }
}

struct AppUsage: Codable, Identifiable {
    var id: String { name }
    let name: String
    let minutes: Int
    let icon: String
    let color: String
}

struct TimeRequest: Identifiable, Codable {
    let id: String
    let memberName: String
    let app: String
    let requestedTime: String
    let timestamp: String
}