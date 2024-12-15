//
//  WeaponSelectViewController.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 10/11/24.
//

import UIKit
import FSPagerView

class WeaponSelectViewController: UIViewController {
    var weaponSelected: ((Int) -> Void)?
    private var weaponListItems: [WeaponListItem] = []
    
    @IBOutlet weak var pagerView: FSPagerView!
    
    init() {
        super.init(nibName: WeaponSelectViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFSPagerView()
                
        weaponListItems = UseCaseProvider.makeWeaponResourceGetUseCase().getWeaponListItems()
        pagerView.reloadData()
    }

    private func setupFSPagerView() {
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 0
        pagerView.isInfinite = true
        pagerView.decelerationDistance = 1
        pagerView.interitemSpacing = 8
        pagerView.transformer = FSPagerViewTransformer(type: .ferrisWheel)
        let nib = UINib(nibName: WeaponSelectCell.className, bundle: nil)
        pagerView.register(nib, forCellWithReuseIdentifier: WeaponSelectCell.className)
    }
}

extension WeaponSelectViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let weaponId = weaponListItems[index].weaponId
        weaponSelected?(weaponId)
        dismiss(animated: true)
    }
}

extension WeaponSelectViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return weaponListItems.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: WeaponSelectCell.className, at: index) as! WeaponSelectCell
        let item = weaponListItems[index]
        cell.configure(
            weaponImage: UIImage(named: item.weaponImageName),
            isHiddenCommingSoonLabel: true
        )
        return cell
    }
}
