import SwiftUI

/// A button that opens the developer menu.
public struct DeveloperMenuButton<Label: View>: View {
    // MARK: - Configuration
    private var label: Label
    private var activationStyle: DeveloperMenuActivationStyle
    
    // MARK: - State
    @State
    private var isPresented = false
    
    // MARK: - View
    public var body: some View {
        button
            .sheet(isPresented: $isPresented, onDismiss: nil) {
                DeveloperMenu()
            }
    }
    
    @ViewBuilder
    private var button: some View {
        switch activationStyle {
        case .standardButton:
            Button(action: activate) {
                label
            }
        case .repeatedTapGesture:
            label
                .onTapGesture(count: 5, perform: activate)
        }
    }
    
    private func activate() {
        isPresented = true
    }
    
    // MARK: - Init
    public init(activationStyle: DeveloperMenuActivationStyle = .standardButton, @ViewBuilder label: () -> Label) {
        self.activationStyle = activationStyle
        self.label = label()
    }
}
