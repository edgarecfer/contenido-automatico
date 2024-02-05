//
//  ContainerCollectionCell.swift
//  ReelAutomatic
//
//  Created by Edgar Cruz on 31/01/24.
//
import Foundation
import AVKit

protocol ContainerCollectionCellDelgate: AnyObject {
    func goToVideo(url: String)
}

class ContainerCollectionCell: UICollectionViewCell {
    
    var playerLayer = AVPlayerLayer()
    var player = AVPlayer()
    var urlString = ""
    var visibleAction = false
    weak var delegate: ContainerCollectionCellDelgate?
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var containerColorView: UIView!
    @IBOutlet weak var containerPlayPause: UIView!
    @IBOutlet weak var viewPlayVideo: UIView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var iconIndicator: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var expandVideo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configIconIndicator()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.videoView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        playerLayer.removeFromSuperlayer()
    }
    
    func videoPlay() {
        let videoURL = URL(string: self.urlString)
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoView.layer.addSublayer(playerLayer)
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        player.play()
    }
    
    func stopVideo() {
        player.pause()
    }
    
    func configureView(url: String) {
        self.urlString = url
        videoPlay()
    }
    
    private func configIconIndicator() {
        iconIndicator.tintColor = .white
    }
    
    private func configIconLoader(HiddenIndicator: Bool) {
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        if HiddenIndicator {
            loaderView.isHidden = HiddenIndicator
            viewPlayVideo.isHidden = !HiddenIndicator
        } else {
            loaderView.isHidden = HiddenIndicator
            viewPlayVideo.isHidden = !HiddenIndicator
        }
    }
    
    private func changeIndicators(isplayin: Bool) {
        iconIndicator.image = (isplayin) ? UIImage(systemName: "pause.circle.fill") : UIImage(systemName: "play.circle.fill")
        playBtn.isHidden = (isplayin) ? true:false
        pauseBtn.isHidden = (isplayin) ? false:true
    }
    
    private func configContainerColor(ishidden: Bool) {
        self.containerColorView.isHidden = ishidden
    }
    
    private func statusAction() {
        visibleAction.toggle()
        
        self.configContainerColor(ishidden: self.visibleAction)
        self.containerPlayPause.isHidden = self.visibleAction
        self.expandVideo.isHidden = self.visibleAction
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        if newStatus == .playing {
                            self?.changeIndicators(isplayin: true)
                            self?.statusAction()
                        } else {
                            self?.changeIndicators(isplayin: false)
                            self?.statusAction()
                        }
                        self?.configIconLoader(HiddenIndicator: true)
                    } else {
                        self?.configIconLoader(HiddenIndicator: false)
                    }
                }
            }
        }
    }
    
    @IBAction func showActions(_ sender: Any) {
        statusAction()
    }
    
    @IBAction func tapPlay(_ sender: Any) {
        if !(player.isPlaying){
            videoPlay()
        }
    }
    
    @IBAction func pauseTap(_ sender: Any) {
        if (player.isPlaying){
            stopVideo()
        }
    }
    
    @IBAction func expandVideoTap(_ sender: Any) {
        self.delegate?.goToVideo(url: self.urlString)
    }
    
}
extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
