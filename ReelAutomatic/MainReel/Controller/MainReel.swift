//
//  MainReel.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 04/12/23.
//

import Foundation
import UIKit
import AVKit

class MainReel: UIViewController {
    
    @IBOutlet weak var mainContainer: UICollectionView!
    
    var api = ListPhotosAPIClients()
    var listPhotographer : SearchPhotosModel?
    var streamController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupServices()
    }
    
    private func setup() {
        configureCollections()
    }
    
    private func setupServices() {
        api.getListPhotos() { listPhotos in
            self.listPhotographer = listPhotos
            DispatchQueue.main.async {
                self.mainContainer.reloadData()
            }
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    private func configureCollections() {
        mainContainer.register(UINib(nibName: "MainCell", bundle: nil), forCellWithReuseIdentifier: "MainCell")
        mainContainer.delegate = self
        mainContainer.dataSource = self
    }
    
}
extension MainReel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhotographer?.videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
        
        let name = listPhotographer?.videos?[indexPath.row].user?.name ?? "ND"
        let image = listPhotographer?.videos?[indexPath.row].image ?? "ND"
        let _ = listPhotographer?.videos?[indexPath.row].video_files?.first?.link ?? "ND"
        cell.configureView(name: name, image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeScreen = UIScreen.main.bounds
        let widthScreen = sizeScreen.width
        let heightScreen = sizeScreen.height * 0.50
        
        return CGSize(width: widthScreen, height: heightScreen)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let url = listPhotographer?.videos?[indexPath.row].video_files?.first?.link ?? "ND"
        (cell as? MainCell)?.videoPlay(urlString: url)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? MainCell)?.player.pause()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = listPhotographer?.videos?[indexPath.row].video_files?.first?.link ?? "ND"
        let streamplayer = AVPlayer(url: URL(string: url)!)
        streamController.player = streamplayer
        
        self.present(self.streamController, animated: true, completion: {
            self.streamController.player?.play()
        })
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        let collectionView = scrollView as! UICollectionView
//        let centerPoint = CGPoint(x: UIScreen.main.bounds.minX, y: scrollView.frame.minY)
//        
//        print("Centro de la pantalla: \(centerPoint)")
        
//        let pageHeight = scrollView.frame.size.height / 2
//        if scrollView.contentOffset.y > pageHeight  {
//            print("Contenido subiendo")
//        } else {
//            print("Contenido bajando")
//        }
//    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let collectionView = scrollView as! UICollectionView
//        
//        let centerPoint = CGPoint(x: UIScreen.main.bounds.midX, y: scrollView.frame.midY)
//        let indexPath = collectionView.indexPathForItem(at: centerPoint)
//        let centerCell = collectionView.cellForItem(at: indexPath!) as! MainCell
//        let nameDisplay = centerCell.nameLbl.text
//        print("Nombre: \(nameDisplay ?? "ND")")
//    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        
//        let pageHeight = scrollView.frame.size.height / 2
//        print("Media de la pantalla: \(pageHeight)")
//        
//        if scrollView.contentOffset.y > pageHeight  {
//            print("Contenido subiendo")
//        } else {
//            print("Contenido bajando")
//        }
//        if(scrollView.contentOffset.x >= (scrollView.contentSize.width - pageWidth) && velocity.x > 0){
//         shouldShowFirstCarrouselElement = true
//         }
//        
//    }
}
