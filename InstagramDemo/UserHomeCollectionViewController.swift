//
//  UserHomeCollectionViewController.swift
//  InstagramDemo
//
//  Created by Tommy on 2020/12/11.
//

import UIKit

private let reuseIdentifier = "UserPhotoGridCollectionViewCell"

class UserHomeCollectionViewController: UICollectionViewController {

    var photo = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //photoDownload()
        
        let itemSpace: CGFloat = 3
        // 設定行數為3(表示每列呈現3張圖片)
        let columnCount: CGFloat = 3
        // 取得FlowLayout物件
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        // 設定cell寬度為(collectionView的寬度 - 2倍間距) / 每列圖片數量
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount - 1)) / columnCount)
        // 將cell寬高設為一樣
        flowLayout?.itemSize = CGSize(width: width, height: width)
        // 讓cell的尺寸依據itemSize, 否則將從auto layout的條件計算cell尺寸
        flowLayout?.estimatedItemSize = .zero
        // 設定cell的間鉅為3
        flowLayout?.minimumInteritemSpacing = itemSpace
        // 設定每列的間鉅為3
        flowLayout?.minimumLineSpacing = itemSpace
        



        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserPhotoGridCollectionViewCell
        
        let url = URL(string: "https://picsum.photos/200")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        task.resume()
//        print(photo[0])
//        cell.photoImageView.image = photo[0]
        return cell
    }
    
    func photoDownload() {
        print("photo download")
        for _ in 1...50 {
            let url = URL(string: "https://picsum.photos/200")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.photo.append(image)
                    }
                }
            }
            task.resume()
        }
        print(photo)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
