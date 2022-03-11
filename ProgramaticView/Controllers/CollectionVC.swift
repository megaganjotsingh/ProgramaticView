//
//  CollectionVC.swift
//  ProgramaticView
//
//  Created by Admin on 09/03/22.
//

import Foundation
import UIKit

class CollectionVC: UIViewController {
    
    var collection: UICollectionView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
    }
    
    
}

extension CollectionVC {
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 104)
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .brown
        view.addSubview(collection)
        
        collection
            .alignEdgesWithSuperview([.safeAreaTop, .left, .right, .safeAreaBottom])
    }
}

extension CollectionVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        return cell
    }
    
    
}

class CollectionCell: UICollectionViewCell {
    
    var label: UILabel!
    var descLabel: UILabel!
    var imageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        set()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        label = LabelFactory(textStyle: .heading, text: .newToThisApp, alignment: .left)
        addSubview(label)
        label.text = "Gagan"
        
        descLabel = LabelFactory(textStyle: .title, alignment: .left)
        addSubview(label)
        descLabel.text = "iOS Dev"
        
        imageView = ImageViewFactory()
        imageView.image = UIImage(named: "backIcon")
        addSubview(imageView)
        imageView
            .width(constant: 40)
            .height(constant: 40)
            .alignEdgesWithSuperview([.top, .left], constants: [8, 16])
            .circled()
        imageView.backgroundColor = .yellow
                
        let stackView = [label, descLabel].asStackView(axis: .vertical, spacing: 8)
        
        addSubview(stackView)
        
        stackView
            .pinEdge(.left, toEdge: .right, ofView: imageView, constant: 12)
            .alignEdge(.top, withView: imageView)
        
    }
    
}
