//
//  WeaponSelectView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI

struct WeaponSelectView: UIViewControllerRepresentable {
    var weaponSelected: ((Int) -> Void)?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let weaponSelectVC = WeaponSelectViewController()
        weaponSelectVC.weaponSelected = weaponSelected
        return weaponSelectVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
