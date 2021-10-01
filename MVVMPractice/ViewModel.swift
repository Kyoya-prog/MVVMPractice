import Foundation
import RxSwift
import UIKit

final class ViewModel {
    let validationText: Observable<String>
    let loadLabelColor: Observable<UIColor>
    
    init(idTextObservable:Observable<String?>,passwordTextObservable:Observable<String?>,model:ModelProtocol){
        let event = Observable
            .combineLatest(idTextObservable, passwordTextObservable)
            .skip(1)
            .flatMap{ idText, passwordText -> Observable<Event<Void>> in
                return model.validate(idText: idText, passwordText: passwordText).materialize()
            }
            .share()
        
        self.validationText = event
            .flatMap{ event -> Observable<String> in
                switch event {
                    
                case .next():
                    return .just("OK!")
                case .error(_):
                    return .just("Error")
                case .completed:
                    return .empty()
                }
            }.startWith("IDとPasswordを入力してください")
        
        self.loadLabelColor = event
            .flatMap{ event -> Observable<UIColor> in
                switch event {
                case .next: return .just(.green)
                case .error: return .just(.red)
                case .completed: return .empty()
                }
            }
    }
}