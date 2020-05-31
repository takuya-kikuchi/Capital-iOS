/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

public protocol TransferConfirmationModuleBuilderProtocol {
    @discardableResult
    func with(viewBinder: WalletFormViewModelBinderProtocol) -> Self

    @discardableResult
    func with(itemViewFactory: WalletFormItemViewFactoryProtocol) -> Self

    @discardableResult
    func with(definitionFactory: WalletFormDefinitionFactoryProtocol) -> Self

    @discardableResult
    func with(viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding) -> Self

    @discardableResult
    func with(completion: TransferCompletion) -> Self

    @discardableResult
    func with(accessoryViewType: WalletAccessoryViewType) -> Self

    @discardableResult
    func with(localizableTitle: LocalizableResource<String>) -> Self
}
