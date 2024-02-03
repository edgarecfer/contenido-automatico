//
//  MainCellTable.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 31/01/24.
//

import UIKit

class MainCellTable: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var containerCollection: UICollectionView!
    @IBOutlet weak var containerImage: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var videos: [Video]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCollections()
        configureImageUser()
        configureContainerView()
    }
    
    private func configCollections() {
        containerCollection.register(UINib(nibName: "ContainerCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ContainerCollectionCell")
        containerCollection.delegate = self
        containerCollection.dataSource = self
    }
    
    private func configureContainerView() {
        mainView.layer.cornerRadius = 20
    }
    
    private func configPageControler() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = videos?.count ?? 0
        pageControl.tintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
    }
    
    private func configureImageUser() {
        containerImage.backgroundColor = .white
        containerImage.layer.cornerRadius = 25
        //Configure ImageView
        imgUser.clipsToBounds = true
        imgUser.contentMode = .scaleAspectFill
        imgUser.layer.cornerRadius = 25
    }
    
    func configureData(img: String, name: String, videos: [Video]) {
        nameUser.text = name
        self.imgUser.sd_setImage(with: URL(string: img), placeholderImage: UIImage(systemName: "photo.fill"))
        self.videos = videos
        configPageControler()
    }
    
    func checkVisibilityOfCell(cell: ContainerCollectionCell,indexPath: IndexPath) {
        if let cellRect = (containerCollection.layoutAttributesForItem(at: indexPath)?.frame) {
            let completelyVisible = containerCollection.bounds.contains(cellRect)
            if completelyVisible{
                cell.videoPlay()
            } else {
                cell.stopVideo()
            }
        }
    }
    
}
extension MainCellTable: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContainerCollectionCell", for: indexPath) as! ContainerCollectionCell
        
        let url = videos?.first?.link ?? "ND"
        
        cell.configureView(url: url)
         
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeScreen = containerCollection.bounds
        let widthScreen = sizeScreen.width
        let heightScreen = sizeScreen.height
        
        return CGSize(width: widthScreen, height: heightScreen)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCell = self.containerCollection.indexPathsForVisibleItems.sorted { top, bottom -> Bool in
            return top.section < bottom.section || top.row < bottom.row
        }.compactMap { indexPath -> UICollectionViewCell? in
            return self.containerCollection.cellForItem(at: indexPath)
        }
        
        let indexPaths = self.containerCollection.indexPathsForVisibleItems.sorted()
        let cellCount = visibleCell.count
        guard let firstCell = visibleCell.first as? ContainerCollectionCell, let firstIndex = indexPaths.first else {return}
        checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
        if cellCount == 1 {return}
        guard let lastCell = visibleCell.last as? ContainerCollectionCell, let lastIndex = indexPaths.last else {return}
        checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}
