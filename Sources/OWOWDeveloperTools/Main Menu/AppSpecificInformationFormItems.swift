import SwiftUI

struct AppSpecificInformationFormItems: View {
    private let info = Array(Information.appSpecific.enumerated())
    
    @ViewBuilder
    var body: some View {
        ForEach(info, id: \.offset) { _, info in
            info._getFormDetailItem()
        }
    }
}

struct AppSpecificInformationFormItems_Previews: PreviewProvider {
    static var previews: some View {
        AppSpecificInformationFormItems()
    }
}
