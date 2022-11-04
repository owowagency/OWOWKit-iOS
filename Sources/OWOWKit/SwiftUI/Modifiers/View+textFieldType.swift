import SwiftUI

public enum OWOWTextType {
    case email
    case givenName
    case familyName
    case newPassword
    case existingPassword
}

extension View {
    /// Call to configure a textField regarding the input type expected.
    @ViewBuilder
    public func owowTextType(_ type: OWOWTextType) -> some View {
        switch type {
        case .email:
            self.textField(\.keyboardType, .emailAddress)
                .textField(\.autocapitalizationType, .none)
                .textField(\.autocorrectionType, .no)
                .textField(\.accessibilityIdentifier, "EmailField")
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .accessibility(identifier: "EmailField")

        case .givenName:
            self.textField(\.textContentType, .givenName)
                .textField(\.accessibilityIdentifier, "GivenNameField")
                .accessibility(identifier: "GivenNameField")
                .textContentType(.givenName)

        case .familyName:
            self.textField(\.textContentType, .familyName)
                .textField(\.accessibilityIdentifier, "FamilyNameField")
                .accessibility(identifier: "FamilyNameField")
                .textContentType(.familyName)

        case .newPassword:
            self.textField(\.textContentType, .newPassword)
                .textField(\.autocorrectionType, .no)
                .textField(\.autocapitalizationType, .none)
                .textField(\.accessibilityIdentifier, "NewPasswordField")
                .textContentType(.newPassword)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .accessibility(identifier: "NewPasswordField")


        case .existingPassword:
            self.textField(\.textContentType, .password)
                .textField(\.autocorrectionType, .no)
                .disableAutocorrection(true)
                .textField(\.accessibilityIdentifier, "ExistingPasswordField")
                .textContentType(.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .accessibility(identifier: "ExistingPasswordField")
        }
    }
}
