import SwiftUI

struct LandingView: View {
    @State private var showAuthView = false
    @State private var showSignUpView = false

    var body: some View {
        ZStack {
            // Background image with gradient overlay (fades from black to clear bottom)
            VStack {
                Spacer()
                ZStack {
                    Image("hse4") // <-- Make sure this image is in Assets.xcassets
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()

                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .frame(height: UIScreen.main.bounds.height * 0.6)
            }
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Logo + Name + Tagline
                VStack(spacing: 8) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)

                    Text("RentIn")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Find your next home")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)

                // Buttons
                VStack(spacing: 16) {
                    Button(action: {
                        showSignUpView = true
                    }) {
                        Text("Sign up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        showAuthView = true
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 40)

                Spacer(minLength: 100)
            }
        }
        .fullScreenCover(isPresented: $showSignUpView) {
            SignUpView()
        }
        .fullScreenCover(isPresented: $showAuthView) {
            AuthView {
                showAuthView = false
            }
        }
    }
}

