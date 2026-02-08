import SwiftUI

struct MemberDetailView: View {
    let member: FamilyMember
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Usage Chart Placeholder
                usageSummaryCard
                
                // App Breakdown
                VStack(alignment: .leading, spacing: 16) {
                    Text("App Usage")
                        .font(.headline)
                    
                    ForEach(member.topApps) { app in
                        HStack {
                            Image(systemName: app.icon)
                                .foregroundStyle(Color(hex: app.color))
                                .frame(width: 32)
                            
                            Text(app.name)
                                .font(.body)
                            
                            Spacer()
                            
                            Text("\(app.minutes)m")
                                .font(.subheadline.monospacedDigit())
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                    }
                }
                
                // Quick Controls
                HStack(spacing: 16) {
                    ActionButton(title: "Add 15m", icon: "plus.circle.fill", color: .blue)
                    ActionButton(title: "Downtime", icon: "moon.fill", color: .indigo)
                }
            }
            .padding()
        }
        .navigationTitle(member.name)
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    var usageSummaryCard: some View {
        VStack {
            Text("Today's Usage")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text("\(member.usedMinutes / 60)h \(member.usedMinutes % 60)m")
                .font(.system(size: 44, weight: .bold, design: .rounded))
            
            Text("Limit: \(member.limitMinutes / 60)h")
                .font(.caption)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(.indigo.opacity(0.1))
                .foregroundStyle(.indigo)
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(RoundedRectangle(cornerRadius: 24).fill(.white))
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.caption.bold())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(color.opacity(0.1))
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}