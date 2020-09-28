/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

protocol HistoryConfigurationProtocol {
    var viewStyle: HistoryViewStyleProtocol { get }
    var cellStyle: TransactionCellStyleProtocol { get }
    var headerStyle: TransactionHeaderStyleProtocol { get }
    var supportsFilter: Bool { get }
    var includesFeeInAmount: Bool { get }
    var emptyStateDataSource: EmptyStateDataSource? { get }
    var emptyStateDelegate: EmptyStateDelegate? { get }
    var registeredCellsMetadata: [String: Any] { get }
    var itemViewModelFactory: HistoryItemViewModelFactoryProtocol? { get }
}

struct HistoryConfiguration: HistoryConfigurationProtocol {
    let viewStyle: HistoryViewStyleProtocol
    let cellStyle: TransactionCellStyleProtocol
    let headerStyle: TransactionHeaderStyleProtocol
    let supportsFilter: Bool
    let includesFeeInAmount: Bool
    let emptyStateDataSource: EmptyStateDataSource?
    weak var emptyStateDelegate: EmptyStateDelegate?
    let registeredCellsMetadata: [String: Any]
    let itemViewModelFactory: HistoryItemViewModelFactoryProtocol?
}