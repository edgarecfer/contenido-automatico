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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupServices()
    }
    
    private func setup() {
        configureCollections()
    }
    
    private func setupServices() {
        api.getListPhotos()
    }
    
    private func configureCollections() {
        
    }
    
}
