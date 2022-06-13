import Foundation
import RxSwift
import RxRelay

final class SecondViewModel {
    
    private let disposeBag = DisposeBag()
    let titleValue = BehaviorRelay<String>(value: "")
    private var descriptionValue: String?
    private var rgbStringValue: String?
    
    init(title: String="", description: String="", rgbString: String="") {
        self.titleValue.accept(title)
        self.descriptionValue = description
        self.rgbStringValue = rgbString
    }
    
    func updateDescription(to newValue: String) {
        self.descriptionValue = newValue
    }
    
    func updateRgbString(to newValue: String) {
        self.rgbStringValue = newValue
    }
}
