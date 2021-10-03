import RxSwift
import Foundation
import UIKit

struct Repository{
    var title:String
}

protocol ModelProtocol {
    var view:UIViewController?{get set}
    func searchRepositories(keyword:String)->Observable<[Repository]>
}
final class Model: ModelProtocol {
    var view: UIViewController?
    func searchRepositories(keyword: String)->Observable<[Repository]> {
        return Observable<[Repository]>.create { observer -> Disposable in
            let url = "https://api.github.com/search/repositories?q=\(keyword)"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                guard let data = data else { return observer.onNext([])}
                if let obj = try! JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let err = err {
                        observer.onError(err)
                        return
                    }
                    if let items = obj["items"] as? [[String: Any]] {
                        let results = items.map{Repository(title: $0["full_name"] as? String ?? "")}
                        observer.onNext(results)
                        return
                    }
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}
