import SwiftUI

struct EnvironmentSummaryFormItems: View {
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @Environment(\.legibilityWeight) var legibilityWeight
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.displayScale) var displayScale
    @Environment(\.sizeCategory) var sizeCategory
    
    @ViewBuilder
    var body: some View {
        FormDetailItem(title: .propertyTitle.accessibilityEnabled, value: accessibilityEnabled)
        FormDetailItem(title: .propertyTitle.legibilityWeight, describing: legibilityWeight)
        FormDetailItem(title: .propertyTitle.colorScheme, describing: colorScheme)
        FormDetailItem(title: .propertyTitle.colorSchemeContrast, describing: colorSchemeContrast)
        FormDetailItem(title: .propertyTitle.displayScale, describing: displayScale)
        FormDetailItem(title: .propertyTitle.sizeCategory, describing: sizeCategory)
    }
}

struct EnvironmentSummaryFormItems_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            EnvironmentSummaryFormItems()
        }
    }
}
