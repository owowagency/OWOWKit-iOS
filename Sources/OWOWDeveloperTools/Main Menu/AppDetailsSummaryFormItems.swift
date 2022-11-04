import SwiftUI

struct AppDetailsSummaryFormItems: View {
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @Environment(\.legibilityWeight) var legibilityWeight
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.displayScale) var displayScale
    @Environment(\.sizeCategory) var sizeCategory
    
    @ViewBuilder
    var body: some View {
        FormDetailItem(Information.AppName())
        FormDetailItem(Information.VersionNumber())
        FormDetailItem(Information.BuildNumber())
    }
}

struct AppDetailsSummaryFormItems_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            AppDetailsSummaryFormItems()
        }
    }
}
