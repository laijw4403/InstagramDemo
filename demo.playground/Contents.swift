import UIKit

var photo = [UIImage]()
func photoDownload() {
    for _ in 1...50 {
        let url = URL(string: "https://picsum.photos/200")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    photo.append(image)
                }
            }
        }
        task.resume()
    }
}

photoDownload()

photo
