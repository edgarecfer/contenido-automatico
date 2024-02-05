//
//  MainView.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 31/01/24.
//

import Foundation
import UIKit
import AVKit

class MainView: UIViewController {
    
    @IBOutlet weak var mainContainerTable: UITableView!
    
    var api = ListPhotosAPIClients()
    var listPhotographer : SearchPhotosModel?
    var streamController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupServices()
    }
    
    private func setup() {
        configTables()
    }
    
    private func configTables() {
        mainContainerTable.register(UINib(nibName: "MainCellTable", bundle: nil), forCellReuseIdentifier: "MainCellTable")
        mainContainerTable.delegate = self
        mainContainerTable.dataSource = self
    }
    
    private func setupServices() {
        api.getListPhotos() { listPhotos in
            self.listPhotographer = listPhotos
            DispatchQueue.main.async {
                self.mainContainerTable.reloadData()
            }
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
}
extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPhotographer?.per_page ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCellTable", for: indexPath) as! MainCellTable
        cell.delegate = self
        
        let image = listPhotographer?.videos?[indexPath.row].image ?? "ND"
        let name = listPhotographer?.videos?[indexPath.row].user?.name ?? "ND"
        let videos = listPhotographer?.videos?[indexPath.row].video_files ?? []
        
        cell.configureData(img: image, name: name, videos: videos)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sizeScreen = UIScreen.main.bounds
        let heightScreen = sizeScreen.height * 0.50
        
        return heightScreen
    }
}

extension MainView: MainCellTableDelegate {
    func goToPresentVideo(url: String) {
        let url = url
        let streamplayer = AVPlayer(url: URL(string: url)!)
        streamController.player = streamplayer
        self.present(self.streamController, animated: true, completion: {
            self.streamController.player?.play()
        })
    }
}
