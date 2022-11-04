import Foundation
import SwiftUI

@available(iOS, introduced: 13, deprecated: 14, message: "Use SwiftUI Link instead")
@available(iOSApplicationExtension, unavailable)
public struct URLButton<Label: View>: View {
    private var button: Button<Label>
    
    public init(url: URL, @ViewBuilder label: () -> Label) {
        self.button = Button(action: {
            UIApplication.shared.open(url)
        }, label: label)
    }
    
    public var body: some View {
        button
    }
}
