//
//  UserHomeCollectionViewController.swift
//  InstagramDemo
//
//  Created by Tommy on 2020/12/11.
//

import UIKit

private let reuseIdentifier = "UserPhotoGridCollectionViewCell"

class UserHomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    @IBOutlet var profileView: UIView!
    var photo = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //photoDownload()
        addProfileView()
        
        
        let itemSpace: CGFloat = 1
        // 設定行數為3(表示每列呈現3張圖片)
        let columnCount: CGFloat = 3
        // 取得FlowLayout物件
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        // 設定cell寬度為(collectionView的寬度 - 2倍間距) / 每列圖片數量, floor為取十進制向下捨去小數點到一個較小的整數 ex. floor(2.9) = 2
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount - 1)) / columnCount)
        // 將cell寬高設為一樣
        flowLayout?.itemSize = CGSize(width: width, height: width)
        // 讓cell的尺寸依據itemSize, 否則將從auto layout的條件計算cell尺寸
        flowLayout?.estimatedItemSize = .zero
        // 設定cell的間鉅
        flowLayout?.minimumInteritemSpacing = itemSpace
        // 設定每列的間鉅
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
        let url = URL(string: "https://picsum.photos/seed/picsum\(indexPath.item)/500")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }.resume()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 379, left: 0, bottom: 0, right: 0)
    }
    
    func addProfileView() {
        // 此屬性為告訴ios自動建立放置位置的約束條件
        profileView.translatesAutoresizingMaskIntoConstraints = false
        // 將視圖加入collectionView
        collectionView.addSubview(profileView)
        // 設定視圖高度為423
        profileView.heightAnchor.constraint(equalToConstant: 379).isActive = true
        // 設定視圖左右與collectionView左右無間距
        profileView.leadingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.trailingAnchor).isActive = true
        // 設定top與contentLayoutGuide top無間距, 並設定Priority為999, 發生衝突時將犧牲此約束條件
        let topConstraint = profileView.topAnchor.constraint(equalTo: collectionView.contentLayoutGuide.topAnchor)
        topConstraint.priority = UILayoutPriority(999)
        topConstraint.isActive = true
        // 設定視圖底部與collectionView top間距40,讓視圖底部保留40不會被捲動
        profileView.bottomAnchor.constraint(greaterThanOrEqualTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
    
    @IBSegueAction func showPhoto(_ coder: NSCoder) -> ShowPhotoViewController? {
        let index = self.collectionView.indexPathsForSelectedItems?.first?.item
        return ShowPhotoViewController(coder: coder, indexPathItem: index!)
    }
    //    func addImageView() {
//        let imageView = UIImageView(image: UIImage(named: "pic0"))
//        // 此屬性為告訴ios自動建立放置位置的約束條件
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        // 將視圖加入collectionView
//        collectionView.addSubview(imageView)
//        // 設定視圖高度為413
//        imageView.heightAnchor.constraint(equalToConstant: 413).isActive = true
//        // 設定視圖左右與collectionView左右無間距
//        imageView.leadingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.leadingAnchor).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: collectionView.frameLayoutGuide.trailingAnchor).isActive = true
//        // 設定top與contentLayoutGuide top無間距, 並設定Priority為999, 發生衝突時將犧牲此約束條件
//        let topConstraint = imageView.topAnchor.constraint(equalTo: collectionView.contentLayoutGuide.topAnchor)
//        topConstraint.priority = UILayoutPriority(999)
//        topConstraint.isActive = true
//        // 設定視圖底部與collectionView top間距40,讓視圖底部保留40不會被捲動
//        imageView.bottomAnchor.constraint(greaterThanOrEqualTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
//    }

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


