/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public protocol WalletCommandFactoryProtocol: class {
    func prepareSendCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol
    func prepareReceiveCommand(for assetId: IRAssetId?) -> WalletPresentationCommandProtocol
    func prepareAssetDetailsCommand(for assetId: IRAssetId) -> AssetDetailsCommadProtocol
    func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol
    func prepareWithdrawCommand(for assetId: IRAssetId, optionId: String)
        -> WalletPresentationCommandProtocol
}

public protocol CommonWalletContextProtocol: WalletCommandFactoryProtocol {
    func createRootController() throws -> UINavigationController
}
