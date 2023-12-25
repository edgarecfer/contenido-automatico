//
//  MainReel.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 04/12/23.
//

import Foundation
import UIKit

class MainReel: UIViewController {
    
    @IBOutlet weak var mainContainer: UICollectionView!
    
    var api = ListPhotosAPIClients()
    var listPhotographer : SearchPhotosModel?
    
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
extension MainReel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPhotographer?.videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
        
        let name = listPhotographer?.videos?[indexPath.row].user?.name ?? "ND"
        let image = listPhotographer?.videos?[indexPath.row].image ?? "ND"
        let url = listPhotographer?.videos?[indexPath.row].video_files?.first?.link ?? "ND"
        cell.configureView(name: name, image: image, url: url)
        return cell
    }
    
    
}
