//
//  NameRegisterViewFactory.swift
//  Sample_AR-GunMan_Replace_SwiftUI
//
//  Created by ウルトラ深瀬 on 16/1/25.
//

import Foundation
import Combine
import DomainLayer

final class NameRegisterViewFactory {
    static func create(
        score: Double,
        temporaryRankTextSubject: CurrentValueSubject<String, Never>,
        dismissRequestReceiver: DismissRequestReceiver,
        onRegistered: @escaping (Ranking) -> Void
    ) -> NameRegisterView {
        let viewModel = NameRegisterViewModel(
            rankingRepository: RepositoryFactory.create(),
            score: score,
            temporaryRankTextSubject: temporaryRankTextSubject
        )
        return NameRegisterView(
            viewModel: viewModel,
            dismissRequestReceiver: dismissRequestReceiver,
            onRegistered: onRegistered
        )
    }
}
