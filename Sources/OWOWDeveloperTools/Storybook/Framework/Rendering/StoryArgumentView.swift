import SwiftUI

struct StoryArgumentView<Target>: View {
    @Binding var target: Target
    var name: String
    var keyPath: PartialKeyPath<Target>
    
    @ViewBuilder
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            switch keyPath {
            case let keyPath as WritableKeyPath<Target, Bool>:
                Toggle(name, isOn: makeBinding(keyPath))
            case let keyPath as WritableKeyPath<Target, String>:
                TextField(name, text: makeBinding(keyPath))
            default:
                if let customUIType = type(of: keyPath).valueType as? any CustomArgumentUIRendering.Type {
                    customUIType.internalRenderArgumentUI(root: $target, keyPath: keyPath)
                } else {
                    Text.storybook.unsupportedType(String(describing: type(of: keyPath).valueType))
                }
            }
        }
        .labelsHidden()
        .textFieldStyle(.roundedBorder)
    }
    
    func makeBinding<T>(_ keyPath: WritableKeyPath<Target, T>) -> Binding<T> {
        Binding(get: { target[keyPath: keyPath] }, set: { target[keyPath: keyPath] = $0 })
    }
}
