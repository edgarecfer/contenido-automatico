//
//  VideoCell.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 07/12/23.
//

import UIKit
import AVKit

class VideoCell: UICollectionViewCell {
    
    @IBOutlet weak var containerViewVideo: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func videplay(urlString: String) {
        let videoURL = URL(string: urlString)
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.containerViewVideo.bounds
        self.containerViewVideo.layer.addSublayer(playerLayer)
        player.play()
    }
    
}
