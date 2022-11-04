import SwiftUI

struct FormDetailItem: View {
    var title: Text
    var value: Text
    
    var body: some View {
        HStack {
            title
                .layoutPriority(1)
            
            value
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .multilineTextAlignment(.trailing)
        }
    }
    
    init(title: Text, value: Text) {
        self.title = title
        self.value = value
    }
    
    init(title: Text, value: Bool) {
        self.title = title
        self.value = Text(value ? "✅" : "❌")
    }
    
    init<T>(title: Text, describing value: T?) {
        self.title = title
        
        if let value = value {
            self.value = Text(String(describing: value))
        } else {
            self.value = Text("nil")
        }
    }
}

extension FormDetailItem {
    init<Info: InformationGathering>(_ info: Info) where Info.Info == String {
        self = .init(title: Text(info.title), value: Text(info.gatherInfo()))
    }
    
    init<Info: InformationGathering>(_ info: Info) where Info.Info == String? {
        self = .init(title: Text(info.title), value: Text(info.gatherInfo() ?? "Unknown"))
    }
}

struct FormDetailItem_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            FormDetailItem(title: Text("Foo"), value: Text("Bar"))
        }
    }
}

