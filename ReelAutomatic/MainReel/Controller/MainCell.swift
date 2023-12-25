//
//  MainCell.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 05/12/23.
//

import UIKit
import SDWebImage
import AVKit

class MainCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureView(name: String, image: String, url: String) {
        nameLbl.text = name
        self.image.sd_setImage(with: URL(string: image), placeholderImage: UIImage(systemName: "photo.fill"))
        videplay(urlString: url)
    }
    
    func videplay(urlString: String) {
        let videoURL = URL(string: urlString)
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
}
