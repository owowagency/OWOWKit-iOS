import SwiftUI

public protocol AnyInformationGathering {
    func _getFormDetailItem() -> AnyView
}

public protocol InformationGathering: AnyInformationGathering {
    associatedtype Info
    
    var title: String { get }
    
    func gatherInfo() -> Info
}

public extension InformationGathering where Info == String {
    func _getFormDetailItem() -> AnyView {
        FormDetailItem(self)
            .erasedToAnyView()
    }
}

public extension InformationGathering where Info == String? {
    func _getFormDetailItem() -> AnyView {
        FormDetailItem(self)
            .erasedToAnyView()
    }
}
