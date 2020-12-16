//
//  ShowPhotoViewController.swift
//  InstagramDemo
//
//  Created by Tommy on 2020/12/16.
//

import UIKit

class ShowPhotoViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    var indexPathItem: Int!
    
    init?(coder: NSCoder,indexPathItem: Int){
        self.indexPathItem = indexPathItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showPhoto(index: indexPathItem)
        
    }
    func showPhoto(index: Int){
        let url = URL(string: "https://picsum.photos/seed/picsum\(index)/500")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
        }.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
