//
//  ContainerCollectionCell.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 31/01/24.
//

import UIKit
import AVKit

class ContainerCollectionCell: UICollectionViewCell {
    
    var playerLayer = AVPlayerLayer()
    var player = AVPlayer()
    var urlString = ""
    
    @IBOutlet weak var videoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.videoView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        playerLayer.removeFromSuperlayer()
    }
    
    func configureView(url: String) {
        self.urlString = url
        videoPlay()
    }
    
    func videoPlay() {
        let videoURL = URL(string: self.urlString)
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func stopVideo() {
        player.pause()
    }
    
}
