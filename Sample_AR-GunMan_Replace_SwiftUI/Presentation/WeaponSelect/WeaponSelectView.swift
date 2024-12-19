//
//  WeaponSelectView.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 15/12/24.
//

import SwiftUI

struct WeaponSelectView: View {
    @Bindable private var viewModel: WeaponSelectViewModel
    private var weaponSelected: ((Int) -> Void)
    
    init(
        viewModel: WeaponSelectViewModel,
        weaponSelected: @escaping (Int) -> Void
    ) {
        self.viewModel = viewModel
        self.weaponSelected = weaponSelected
    }
    
    var body: some View {
        WeaponSelectViewControllerRepresentable(
            weaponSelected: weaponSelected,
            weaponListItems: $viewModel.weaponListItems
        )
        .onAppear {
            viewModel.onViewAppear()
        }
    }
}

struct WeaponSelectViewControllerRepresentable: UIViewControllerRepresentable {
    private var weaponSelected: ((Int) -> Void)
    @Binding private var weaponListItems: [WeaponListItem]
    @Environment(\.dismiss) private var dismiss
    
    init(
        weaponSelected: @escaping (Int) -> Void,
        weaponListItems: Binding<[WeaponListItem]>
    ) {
        self.weaponSelected = weaponSelected
        self._weaponListItems = weaponListItems
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
