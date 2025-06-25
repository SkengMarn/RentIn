import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false

    @State private var accountType = ""
    @State private var showAccountMenu = false
    @State private var agreedToTerms = false

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Create your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)

                    // Name
                    TextField("Full Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.words)

                    // Email
                    TextField("Email Address", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    // Password with eye icon and requirements info
                    ZStack(alignment: .trailing) {
                        Group {
                            if showPassword {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        HStack(spacing: 12) {
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }

                            Button(action: {
                                alertMessage = """
                                Password Requirements:
                                • At least 8 characters
                                • Include letters & numbers
                                • Use one special character (!@#$)
                                """
                                showAlert = true
                            }) {
                                Image(systemName: "exclamationmark.circle")
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.trailing, 10)
                    }

                    // Dropdown for account type
                    Menu {
                        Button("I'm a Renter", action: { accountType = "Renter" })
                        Button("I'm a Landlord", action: { accountType = "Landlord" })
                    } label: {
                        HStack {
                            Text(accountType.isEmpty ? "Select Account Type" : accountType)
                                .foregroundColor(accountType.isEmpty ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }

                    // Terms and Conditions
                    Toggle(isOn: $agreedToTerms) {
                        Text("I agree to the Terms and Conditions")
                            .font(.footnote)
                    }

                    // Sign Up Button
                    Button(action: signUp) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(agreedToTerms ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!agreedToTerms)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func signUp() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !accountType.isEmpty else {
            alertMessage = "Please fill out all fields."
            showAlert = true
            return
        }

        // Example: Handle API call here
        alertMessage = "Signed up successfully as \(accountType)."
        showAlert = true
    }
}

