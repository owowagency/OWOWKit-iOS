import SwiftUI
import OWOWKit

public protocol CustomArgumentUIRendering {
    static func renderArgumentUI<Root>(root: Binding<Root>, keyPath: WritableKeyPath<Root, Self>) -> AnyView
}

extension CustomArgumentUIRendering {
    static func internalRenderArgumentUI<Root>(root: Binding<Root>, keyPath: PartialKeyPath<Root>) -> AnyView {
        Group {
            if let keyPath = keyPath as? WritableKeyPath<Root, Self> {
                renderArgumentUI(root: root, keyPath: keyPath)
            } else {
                Text(verbatim: "Internal inconsistency")
            }
        }
        .erasedToAnyView()
    }
}

extension CaseIterable where Self: CustomArgumentUIRendering & Hashable {
    public static func renderArgumentUI<Root>(root: Binding<Root>, keyPath: WritableKeyPath<Root, Self>) -> AnyView {
        let picker = Picker("", selection: root[dynamicMember: keyPath]) {
            ForEach(Array(allCases), id: \.self) { theCase in
                Text(String(describing: theCase))
                    .tag(theCase)
            }
        }
        
        if #available(iOS 14, *) {
            return picker
                .pickerStyle(MenuPickerStyle())
                .erasedToAnyView()
        } else {
            return picker
                .erasedToAnyView()
        }
    }
}
