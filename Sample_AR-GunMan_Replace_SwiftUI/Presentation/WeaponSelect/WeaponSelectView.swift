//
//  WeaponSelectView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI

struct WeaponSelectView: UIViewControllerRepresentable {
    var weaponSelected: ((Int) -> Void)
    @Environment(\.dismiss) private var dismiss
    
    init(weaponSelected: @escaping (Int) -> Void) {
        self.weaponSelected = weaponSelected
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let weaponSelectVC = WeaponSelectViewController()
        weaponSelectVC.weaponSelected = { weaponId in
            // このViewの利用側へ選択されたweaponIdをコールバック
            weaponSelected(weaponId)
            // 画面を閉じる
            dismiss()
        }
        return weaponSelectVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
