import UIKit
import JavaScriptCore

enum JSBundleSource {
    case Assets
    case Bundler
}

func loadJSBundle(fromSource: JSBundleSource, then callback: @escaping (String) -> Void) {
    switch (fromSource) {
    case JSBundleSource.Assets: readJSFromAssets(callback)
    case JSBundleSource.Bundler: fetchJSFromBundler(callback)
    }
}

private func readJSFromAssets(_ callback: @escaping (String) -> Void) {
    let mainBundleUrl = Bundle.main.url(forResource:"index", withExtension: "js")!
    do {
        let mainBundle = try String.init(contentsOf: mainBundleUrl)
        callback(mainBundle)
    } catch {
        print("Failed to load main bundle!")
    }
}

private func fetchJSFromBundler(_ callback: @escaping (String) -> Void) {
    let bundleUrl = "http://localhost:8080/src/index.bundle?dev=true&platform=ios"
    var request = URLRequest(url: URL(string: bundleUrl)!)
    request.httpMethod = "GET"
    URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
        if let httpResponse = response as? HTTPURLResponse {
            if (httpResponse.statusCode != 200) {
                print("Failed to fetch main bundle!")
            } else {
                let decodedData = String(data: data!, encoding: String.Encoding.utf8)!
                DispatchQueue.main.async { callback(decodedData) }
            }
        }
    }).resume()
}
