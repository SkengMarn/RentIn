import SwiftUI

struct AppRootView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                ContentView()
            } else {
                LandingView()
            }
        }
    }
}
