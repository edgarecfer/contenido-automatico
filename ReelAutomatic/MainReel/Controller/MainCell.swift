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
    
    
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var containerImage: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playIcon: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    var playerLayer = AVPlayerLayer()
    var player = AVPlayer()
    var urlString = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureImagePortrait()
        configureMainConteiner()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.videoView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        playerLayer.removeFromSuperlayer()
    }
    
    private func configureMainConteiner() {
        playIcon.tintColor = UIColor.white
        mainContainer.layer.cornerRadius = 20
    }
    
    func configureView(name: String, image: String, url: String) {
        self.urlString = url
        nameLbl.text = name
        self.image.sd_setImage(with: URL(string: image), placeholderImage: UIImage(systemName: "photo.fill"))
    }
    
    func videoPlay() {
        playIcon.isHidden = true
        
        let videoURL = URL(string: self.urlString)
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func stopVideo() {
        playIcon.isHidden = false
        
        player.pause()
    }
    
    private func configureImagePortrait() {
        containerImage.backgroundColor = .white
        containerImage.layer.cornerRadius = 25
        //Configure ImageView
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
    }
    
}
