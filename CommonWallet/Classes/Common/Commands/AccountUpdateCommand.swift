import Foundation

final class AccountUpdateCommand: WalletCommandProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func execute() throws {
        resolver.eventCenter.notify(with: AccountUpdateEvent())
    }
}
