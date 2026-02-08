import Foundation
import SwiftUI

class GuardianViewModel: ObservableObject {
    @Published var members: [FamilyMember] = []
    @Published var requests: [TimeRequest] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "InitialData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(FamilyDataWrapper.self, from: data)
            self.members = decoded.familyMembers
            self.requests = decoded.pendingRequests
        } catch {
            print("Error decoding: \(error)")
        }
    }
    
    func togglePause(for memberId: String) {
        if let index = members.firstIndex(where: { $0.id == memberId }) {
            withAnimation(.spring()) {
                members[index].isPaused.toggle()
            }
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
}

struct FamilyDataWrapper: Codable {
    let familyMembers: [FamilyMember]
    let pendingRequests: [TimeRequest]
}