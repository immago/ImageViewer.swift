import UIKit
#if canImport(Kingfisher)
import Kingfisher
#endif

public protocol ImageLoader {
    func loadImage(_ url: URL, placeholder: UIImage?, imageView: UIImageView, completion: @escaping (_ image: UIImage?) -> Void)
}

public struct URLSessionImageLoader: ImageLoader {
    public init() {}

    public func loadImage(_ url: URL, placeholder: UIImage?, imageView: UIImageView, completion: @escaping (UIImage?) -> Void) {
        if let placeholder = placeholder {
            imageView.image = placeholder
        }

        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                imageView.image = image
                completion(image)
            }
        }
    }
}

#if canImport(Kingfisher)
struct SDWebImageLoader: @preconcurrency ImageLoader {
    
    @MainActor 
    func loadImage(_ url: URL, placeholder: UIImage?, imageView: UIImageView, completion: @escaping (UIImage?) -> Void) {
        
        imageView.kf.setImage(with: url,
                              placeholder: placeholder,
                              options: nil,
                              progressBlock: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(value.image)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
#endif
