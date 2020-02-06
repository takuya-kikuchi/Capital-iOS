/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class WithdrawConfirmationAssembly: WithdrawConfirmationAssemblyProtocol {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.loadingViewFactory = WalletLoadingOverlayFactory(style: resolver.style.loadingOverlayStyle)
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style

        view.title = L10n.Confirmation.title

        let localizationManager = resolver.localizationManager
        localizationManager?.addObserver(with: view) { [weak view] (_, _) in
            view?.title = L10n.Confirmation.title
        }

        let coordinator = WithdrawConfirmationCoordinator(resolver: resolver)

        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let amountFormatter = resolver.amountFormatterFactory.createDisplayFormatter(for: asset)

        let presenter = WithdrawConfirmationPresenter(view: view,
                                                      coordinator: coordinator,
                                                      walletService: walletService,
                                                      withdrawInfo: info,
                                                      asset: asset,
                                                      withdrawOption: option,
                                                      style: resolver.style,
                                                      amountFormatter: amountFormatter,
                                                      eventCenter: resolver.eventCenter,
                                                      feeDisplayStrategy: resolver.feeDisplayStrategy)
        view.presenter = presenter

        presenter.localizationManager = localizationManager

        return view
    }
}
