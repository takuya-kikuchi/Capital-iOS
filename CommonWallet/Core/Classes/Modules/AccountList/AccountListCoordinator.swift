/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class AccountListCoordinator: AccountListCoordinatorProtocol {
    
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}
