//
//  WeaponSelectCell.swift
//  AR-GunMan
//
//  Created by 深瀬 貴将 on 2020/11/03.
//  Copyright © 2020 fukase. All rights reserved.
//

import UIKit

final class WeaponSelectCell: UICollectionViewCell {
    @IBOutlet private weak var weaponImageView: UIImageView!
    @IBOutlet private weak var commingSoonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(
        weaponImage: UIImage?,
        isHiddenCommingSoonLabel: Bool
    ) {
        weaponImageView.image = weaponImage
        commingSoonLabel.isHidden = isHiddenCommingSoonLabel
    }
}
