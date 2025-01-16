//
//  WeaponSelectView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI
import DomainLayer

struct WeaponSelectView: View {
    @State var viewModel: WeaponSelectViewModel
    @State var weaponSelected: ((Int) -> Void)
    
    var body: some View {
        WeaponSelectViewControllerRepresentable(
            weaponSelected: weaponSelected,
            weaponListItems: viewModel.weaponListItems
        )
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

struct WeaponSelectViewControllerRepresentable: UIViewControllerRepresentable {
    private var weaponSelected: ((Int) -> Void)
    private var weaponListItems: [WeaponListItem]
    @Environment(\.dismiss) private var dismiss
    
    init(
        weaponSelected: @escaping (Int) -> Void,
        weaponListItems: [WeaponListItem]
    ) {
        self.weaponSelected = weaponSelected
        self.weaponListItems = weaponListItems
    }
    
    func makeUIViewController(context: Context) -> WeaponSelectViewController {
        let weaponSelectVC = WeaponSelectViewController()
        weaponSelectVC.weaponSelected = { weaponId in
            // このViewの利用側へ選択されたweaponIdをコールバック
            weaponSelected(weaponId)
            // 画面を閉じる
            dismiss()
        }
        return weaponSelectVC
    }
    
    func updateUIViewController(_ uiViewController: WeaponSelectViewController, context: Context) {
        uiViewController.updateWeaponListItems(weaponListItems)
    }
}
