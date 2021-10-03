import Foundation
import RxSwift
import UIKit
import RxRelay

protocol Input{
    var searchKeyword:AnyObserver<String>{ get set }
}

protocol Output{
    var repositories:Observable<[Repository]>{ get set }
}

final class ViewModel:Input,Output {
    var view: UIViewController?
    
    var searchKeyword: AnyObserver<String>
    
    var repositories: Observable<[Repository]>
    
    let model = Model()
    
    let disposeBag = DisposeBag()
    
    init(model:ModelProtocol = Model()){
        let _searchKeyword = PublishRelay<String>()

        searchKeyword = AnyObserver<String>(){ event in
            guard let text = event.element else { return }
            _searchKeyword.accept(text)
            }
            
        let searchWithKeyword = _searchKeyword
            .debounce(.milliseconds(300), scheduler: ConcurrentMainScheduler.instance)
            .flatMap{ text -> Observable<String> in
                guard text.count > 2 else {
                    return .empty()
                }
                return .just(text)
            }
            .share()
        let b = Binder()
        
        let _repositories = PublishRelay<[Repository]>()
        repositories = _repositories.asObservable()
        
        let searchResult = searchWithKeyword.flatMap{ text in
            model.searchRepositories(keyword: text)
                .materialize()
        }
            .share()
        
        searchResult.flatMap{ $0.element.map(Observable.just) ?? .empty()}.bind(to: _repositories).disposed(by: disposeBag)
        
        searchResult.flatMap{ $0.error.map(Observable.just) ?? .empty()}.subscribe { error in
            print("エラーハンドリング",error)
        }.disposed(by: disposeBag)
    }

}
