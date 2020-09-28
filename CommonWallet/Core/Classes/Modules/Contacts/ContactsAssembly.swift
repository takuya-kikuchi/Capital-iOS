/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class ContactsAssembly: ContactsAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol,
                             selectedAsset: WalletAsset) -> ContactsViewProtocol? {

        let view = ContactsViewController(nibName: "ContactsViewController", bundle: Bundle(for: self))
        
        let config = resolver.contactsConfiguration
        view.configuration = config
        view.style = resolver.style
        
        let coordinator = ContactsCoordinator(resolver: resolver)
        
        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: resolver.networkOperationFactory,
                                                      identifierFactory: resolver.singleValueIdentifierFactory)

        guard let contactsDataProvider = try? dataProviderFactory.createContactsDataProvider() else {
            return nil
        }
        
        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let viewModelFactory: ContactsViewModelFactoryProtocol

        if let customViewModelFactory = config.viewModelFactoryWrapper {
            let defaultFactory = ContactsViewModelFactory(avatarRadius: ContactCell.avatarRadius,
                                                          nameIconStyle: config.cellStyle.contactStyle.nameIcon)
            viewModelFactory = ContactsFactoryWrapper(customFactory: customViewModelFactory,
                                                      defaultFactory: defaultFactory)
        } else {
            viewModelFactory = ContactsViewModelFactory(avatarRadius: ContactCell.avatarRadius,
                                                        nameIconStyle: config.cellStyle.contactStyle.nameIcon)
        }

        let withdrawOptions = config.withdrawOptionsPosition == .tableAction ? resolver.account.withdrawOptions : []

        let actionFactory: ContactsActionViewModelFactoryProtocol

        if let customActionFactory = config.actionFactoryWrapper {
            let defaultFactory = ContactsActionViewModelFactory(commandFactory: resolver.commandFactory,
                                                                scanPosition: config.scanPosition,
                                                                withdrawOptions: withdrawOptions)

            actionFactory = ContactsActionFactoryWrapper(customFactory: customActionFactory,
                                                         defaultFactory: defaultFactory)
        } else {
            actionFactory = ContactsActionViewModelFactory(commandFactory: resolver.commandFactory,
                                                           scanPosition: config.scanPosition,
                                                           withdrawOptions: withdrawOptions)
        }

        let presenter = ContactsPresenter(view: view,
                                          coordinator: coordinator,
                                          dataProvider: contactsDataProvider,
                                          walletService: walletService,
                                          viewModelFactory: viewModelFactory,
                                          actionViewModelFactory: actionFactory,
                                          selectedAsset: selectedAsset,
                                          currentAccountId: resolver.account.accountId,
                                          localSearchEngine: config.localSearchEngine,
                                          canFindItself: config.canFindItself)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
}