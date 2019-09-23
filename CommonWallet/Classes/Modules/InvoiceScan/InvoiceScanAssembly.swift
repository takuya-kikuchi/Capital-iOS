/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class InvoiceScanAssembly: InvoiceScanAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol) -> InvoiceScanViewProtocol? {
        let networkService = WalletService(networkResolver: resolver.networkResolver,
                                           operationFactory: resolver.networkOperationFactory)

        let qrScanServiceFactory = WalletQRCaptureServiceFactory()

        let view = InvoiceScanViewController(nibName: "InvoiceScanViewController", bundle: Bundle(for: self))
        view.style = resolver.invoiceScanConfiguration.viewStyle
        let coordinator = InvoiceScanCoordinator(resolver: resolver)

        let presenter = InvoiceScanPresenter(view: view,
                                             coordinator: coordinator,
                                             currentAccountId: resolver.account.accountId,
                                             networkService: networkService,
                                             qrScanServiceFactory: qrScanServiceFactory)

        if resolver.invoiceScanConfiguration.supportsUpload {
            view.showsUpload = true
            presenter.qrExtractionService = WalletQRExtractionService(processingQueue: .global())
        } else {
            view.showsUpload = false
        }

        presenter.logger = resolver.logger

        view.presenter = presenter

        return view
    }
}
