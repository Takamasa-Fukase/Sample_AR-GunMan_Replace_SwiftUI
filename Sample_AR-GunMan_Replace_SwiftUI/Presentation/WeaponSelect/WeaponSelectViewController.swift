//
//  WeaponSelectViewController.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 10/11/24.
//

import UIKit

class WeaponSelectViewController: UIViewController {
    var weaponSelected: ((Int) -> Void)?
    private var weaponListItems = [WeaponListItem]()
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    init() {
        super.init(nibName: WeaponSelectViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    func updateWeaponListItems(_ items: [WeaponListItem]) {
        weaponListItems = items
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: WeaponSelectCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: WeaponSelectCell.className)
    }
}

extension WeaponSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaponListItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeaponSelectCell.className, for: indexPath) as! WeaponSelectCell
        let item = weaponListItems[indexPath.row]
        cell.configure(
            weaponImage: UIImage(named: item.weaponImageName),
            isHiddenCommingSoonLabel: true
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let weaponId = weaponListItems[indexPath.row].weaponId
        weaponSelected?(weaponId)
    }
}

extension WeaponSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 240, height: 240)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 80
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
