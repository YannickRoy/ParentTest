import SwiftUI

struct RequestCarousel: View {
    let requests: [TimeRequest]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pending Requests")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(requests) { request in
                        HStack(spacing: 12) {
                            Circle()
                                .fill(.orange.opacity(0.2))
                                .frame(width: 40, height: 40)
                                .overlay(Image(systemName: "hourglass").foregroundStyle(.orange))
                            
                            VStack(alignment: .leading) {
                                Text("\(request.memberName) wants \(request.requestedTime)")
                                    .font(.subheadline.bold())
                                Text("for \(request.app) • \(request.timestamp)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            HStack(spacing: 8) {
                                Button("Approve") {}.buttonStyle(.borderedProminent).controlSize(.small)
                                Button("Deny") {}.buttonStyle(.bordered).controlSize(.small)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                        .shadow(color: .black.opacity(0.03), radius: 5)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}