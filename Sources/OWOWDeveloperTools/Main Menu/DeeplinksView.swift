import SwiftUI

public struct DeeplinksView: View {
    var dismiss: () -> Void
    
    var links = DeveloperMenu.deeplinkURLs.sorted(by: { $0.key < $1.key })
    
    public init(dismiss: @escaping () -> Void) {
        self.dismiss = dismiss
    }
    
    public var body: some View {
        ForEach(links, id: \.key) { name, url in
            Button(action: {
                dismiss()
                
                if let url = url {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        UIApplication.shared.open(url)
                    }
                }
            }) {
                Text(name)
            }
            .disabled(url == nil)
        }
    }
}
