import SwiftUI

struct ContentView: View {
    @State private var searchQuery: String = ""
    @State private var isBudgetSelected: Bool = false
    @State private var selectedTab: Int = 0
    
    // Updated sample data with image names instead of Image objects
    let aiRecommendedProperties = [
        Property(id: 1, name: "Modern Apartment in Kololo", price: 1200000, distance: 2.5, isVerified: true, imageName: "hse1"),
        Property(id: 2, name: "Cozy Bungalow in Ntinda", price: 850000, distance: 5.1, isVerified: true, imageName: "hse2"),
        Property(id: 3, name: "Luxury Villa in Nakasero", price: 3500000, distance: 3.8, isVerified: false, imageName: "hse3")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // 1. Hero Section
                    heroSection
                    
                    // 2. Search Bar & Filters
                    searchSection
                    
                    // 3. AI Recommendations
                    recommendationsSection
                    
                    // 4. Fraud Prevention Badges
                    trustBadgesSection
                    
                    // 5. How It Works
                    howItWorksSection
                    
                    // 6. Testimonials
                    testimonialsSection
                }
                .padding(.bottom, 50)
            }
            .navigationBarHidden(true)
            .overlay(bottomTabBar, alignment: .bottom)
        }
    }
    
    // MARK: - Subviews
    
    private var heroSection: some View {
        ZStack {
            Image("kampala_banner")
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .overlay(Color.black.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Find Your Perfect Home")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Verified listings • AI-powered matches • Zero fraud")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                
                Button(action: { /* Navigate to search */ }) {
                    Text("Search Properties")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .frame(height: 250)
        .clipped()
    }
    
    private var searchSection: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Location, Budget, or Property Type", text: $searchQuery)
                Button(action: { /* Open advanced filters */ }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    FilterChip(text: "Under 500K UGX", isSelected: $isBudgetSelected)
                    FilterChip(text: "Furnished", icon: "sofa.fill")
                    FilterChip(text: "Near Me", icon: "location.fill")
                    FilterChip(text: "Verified Owners", icon: "checkmark.shield.fill")
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var recommendationsSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Smart Picks for You")
                    .font(.title3.weight(.semibold))
                Image(systemName: "sparkles")
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(aiRecommendedProperties) { property in
                        PropertyCard(property: property)
                            .onTapGesture { /* Show details */ }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var trustBadgesSection: some View {
        VStack(alignment: .leading) {
            Text("Rent Safely")
                .font(.headline)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
                TrustBadge(icon: "doc.text", label: "Ownership Verified")
                TrustBadge(icon: "photo", label: "No Fake Photos")
                TrustBadge(icon: "dollarsign", label: "Secure Payments")
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
        }
    }
    
    private var howItWorksSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("How RentIn Works")
                .font(.title3.weight(.semibold))
                .padding(.horizontal)
            
            StepView(number: 1, icon: "magnifyingglass",
                    title: "Search Smartly",
                    description: "Use AI filters to find perfect matches")
            
            StepView(number: 2, icon: "checkmark.shield",
                    title: "Verify & Visit",
                    description: "All listings pre-checked for fraud")
            
            StepView(number: 3, icon: "signature",
                    title: "Sign Digitally",
                    description: "e-Sign leases in minutes")
        }
        .padding()
    }
    
    private var testimonialsSection: some View {
        VStack(alignment: .leading) {
            Text("What Our Users Say")
                .font(.title3.weight(.semibold))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    TestimonialCard(
                        quote: "Saved me 2 weeks of searching!",
                        author: "Nakato, Kampala",
                        rating: 5
                    )
                    
                    TestimonialCard(
                        quote: "No more fake listings!",
                        author: "Mugisha, Entebbe",
                        rating: 5
                    )
                    
                    TestimonialCard(
                        quote: "Found my home in 3 days",
                        author: "Ochieng, Jinja",
                        rating: 4
                    )
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var bottomTabBar: some View {
        HStack {
            TabBarButton(icon: "house.fill", label: "Home", isSelected: selectedTab == 0) {
                selectedTab = 0
            }
            
            TabBarButton(icon: "magnifyingglass", label: "Search", isSelected: selectedTab == 1) {
                selectedTab = 1
            }
            
            TabBarButton(icon: "doc.text.fill", label: "Contracts", isSelected: selectedTab == 2) {
                selectedTab = 2
            }
            
            TabBarButton(icon: "person.fill", label: "Profile", isSelected: selectedTab == 3) {
                selectedTab = 3
            }
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
    }
}

// MARK: - Supporting Views

struct Property: Identifiable {
    let id: Int
    let name: String
    let price: Int
    let distance: Double
    let isVerified: Bool
    let imageName: String
}

struct PropertyCard: View {
    let property: Property
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(property.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 120)
                .clipped()
                .cornerRadius(8)
                .overlay(
                    property.isVerified ?
                    VerificationBadge().offset(x: 8, y: 8) : nil
                )
            
            Text("UGX \(property.price.formatted())")
                .font(.headline)
            
            Text(property.name)
                .font(.subheadline)
                .lineLimit(1)
            
            Text("\(String(format: "%.1f", property.distance)) km from you")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 200)
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct VerificationBadge: View {
    var body: some View {
        Image(systemName: "checkmark.shield.fill")
            .padding(6)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Circle())
    }
}

struct FilterChip: View {
    let text: String
    var icon: String? = nil
    @Binding var isSelected: Bool
    
    init(text: String, isSelected: Binding<Bool> = .constant(false)) {
        self.text = text
        self._isSelected = isSelected
    }
    
    init(text: String, icon: String) {
        self.text = text
        self.icon = icon
        self._isSelected = .constant(false)
    }
    
    var body: some View {
        HStack(spacing: 4) {
            if let icon = icon {
                Image(systemName: icon)
            }
            Text(text)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? Color.blue : Color(.systemGray5))
        .foregroundColor(isSelected ? .white : .primary)
        .cornerRadius(20)
    }
}

struct TrustBadge: View {
    let icon: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
            
            Text(label)
                .font(.caption2)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
    }
}

struct StepView: View {
    let number: Int
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                Text("\(number)")
                    .foregroundColor(.white)
                    .font(.caption.weight(.bold))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: icon)
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                }
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}

struct TestimonialCard: View {
    let quote: String
    let author: String
    let rating: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("""
                "\(quote)"
                """)
                .font(.callout)
                .italic()
            
            HStack {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .foregroundColor(star <= rating ? .yellow : .gray)
                        .font(.caption)
                }
            }
            
            Text("- \(author)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 200)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct TabBarButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                Text(label)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        
        ContentView()
            .preferredColorScheme(.dark)
    }
}
