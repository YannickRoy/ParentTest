import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = GuardianViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header Section
                    headerSection
                    
                    // Requests Section
                    if !viewModel.requests.isEmpty {
                        RequestCarousel(requests: viewModel.requests)
                    }
                    
                    // Family Members Grid
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Family Members")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.members) { member in
                                NavigationLink(value: member.id) {
                                    MemberCard(member: member) {
                                        viewModel.togglePause(for: member.id)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationDestination(for: String.self) { id in
                if let member = viewModel.members.first(where: { $0.id == id }) {
                    MemberDetailView(member: member)
                }
            }
        }
    }
    
    var headerSection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Guardian")
                    .font(.largeTitle.bold())
                Text("Family Dashboard")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title2)
                .padding(10)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.05), radius: 5)
        }
        .padding(.horizontal)
    }
}

struct MemberCard: View {
    let member: FamilyMember
    var onPauseToggle: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: member.avatar)
                    .font(.system(size: 40))
                    .foregroundStyle(.indigo)
                    .background(Circle().fill(.indigo.opacity(0.1)).frame(width: 50, height: 50))
                
                VStack(alignment: .leading) {
                    Text(member.name)
                        .font(.headline)
                    Text(member.role)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button(action: onPauseToggle) {
                    Image(systemName: member.isPaused ? "play.fill" : "pause.fill")
                        .foregroundStyle(member.isPaused ? .green : .red)
                        .padding(12)
                        .background(member.isPaused ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(member.remainingTime)
                        .font(.subheadline.bold())
                    Spacer()
                    Text("\(Int(member.progress * 100))%")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                GeometryReader { geo in
                    Z shipyard in
                    ZStack(alignment: .leading) {
                        Capsule().fill(.gray.opacity(0.1))
                        Capsule()
                            .fill(member.progress > 0.9 ? .red : .indigo)
                            .frame(width: geo.size.width * member.progress)
                    }
                }
                .frame(height: 8)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 24).fill(.white))
        .shadow(color: .black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}