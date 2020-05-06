/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol OperationDefinitionViewFactoryProtocol {
    func createHeaderViewForItem(type: OperationDefinitionType) -> MultilineTitleIconView
    func createErrorViewForItem(type: OperationDefinitionType) -> ContainingErrorView
    func createAssetView() -> SelectedAssetView
    func createReceiverView() -> ReceiverFormView
    func createAmountView() -> AmountInputView
    func createFeeView() -> FeeView
    func createDescriptionView() -> DescriptionInputView
}

struct OperationDefinitionViewFactory: OperationDefinitionViewFactoryProtocol {
    let style: OperationDefinitionViewStyle

    init(style: OperationDefinitionViewStyle) {
        self.style = style
    }

    func createHeaderViewForItem(type: OperationDefinitionType) -> MultilineTitleIconView {
        switch type {
        case .asset:
            return createHeaderViewForStyle(style.assetStyle.containingHeaderStyle)
        case .receiver:
            return createHeaderViewForStyle(style.receiverStyle.containingHeaderStyle)
        case .amount:
            return createHeaderViewForStyle(style.amountStyle.containingHeaderStyle)
        case .fee:
            return createHeaderViewForStyle(style.feeStyle.containingHeaderStyle)
        case .description:
            return createHeaderViewForStyle(style.descriptionStyle.containingHeaderStyle)
        }
    }

    func createErrorViewForItem(type: OperationDefinitionType) -> ContainingErrorView {
        switch type {
        case .asset:
            return createErrorViewForStyle(style.assetStyle.containingErrorStyle)
        case .receiver:
            return createErrorViewForStyle(style.receiverStyle.containingErrorStyle)
        case .amount:
            return createErrorViewForStyle(style.amountStyle.containingErrorStyle)
        case .fee:
            return createErrorViewForStyle(style.feeStyle.containingErrorStyle)
        case .description:
            return createErrorViewForStyle(style.descriptionStyle.containingErrorStyle)
        }
    }

    func createAssetView() -> SelectedAssetView {
        let optionalView = UINib(nibName: "SelectedAssetView", bundle: Bundle(for: SelectedAssetView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? SelectedAssetView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.assetStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.assetStyle.separatorStyle.lineWidth

        view.titleControl.titleLabel.textColor = style.assetStyle.titleStyle.color
        view.titleControl.titleLabel.font = style.assetStyle.titleStyle.font
        view.accessoryIcon = style.assetStyle.switchIcon

        return view
    }

    func createReceiverView() -> ReceiverFormView {
        let view = ReceiverFormView()

        view.borderedView.strokeColor = style.receiverStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.receiverStyle.separatorStyle.lineWidth

        view.titleLabel.textColor = style.receiverStyle.textStyle.color
        view.titleLabel.font = style.receiverStyle.textStyle.font

        view.horizontalSpacing = style.receiverStyle.horizontalSpacing
        view.contentInsets = style.receiverStyle.contentInsets

        return view
    }

    func createAmountView() -> AmountInputView {
        let optionalView = UINib(nibName: "AmountInputView", bundle: Bundle(for: SelectedAssetView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? AmountInputView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.amountStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.amountStyle.separatorStyle.lineWidth

        view.amountField.textColor = style.amountStyle.inputStyle.color
        view.amountField.font = style.amountStyle.inputStyle.font

        view.assetLabel.textColor = style.amountStyle.assetStyle.color
        view.assetLabel.font = style.amountStyle.assetStyle.font

        if let caretColor = style.amountStyle.caretColor {
            view.amountField.tintColor = caretColor
        }

        view.keyboardIndicatorIcon = style.amountStyle.keyboardIcon
        view.keyboardIndicatorMode = style.amountStyle.keyboardIndicatorMode

        view.contentInsets = style.amountStyle.contentInsets

        return view
    }

    func createFeeView() -> FeeView {
        let optionalView = UINib(nibName: "FeeView", bundle: Bundle(for: FeeView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? FeeView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.feeStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.feeStyle.separatorStyle.lineWidth

        if let activityIndicatorColor = style.feeStyle.activityTintColor {
            view.activityIndicator.tintColor = activityIndicatorColor
        }

        view.titleLabel.textColor = style.feeStyle.titleStyle.color
        view.titleLabel.font = style.feeStyle.titleStyle.font

        view.contentInsets = style.feeStyle.contentInsets

        return view
    }

    func createDescriptionView() -> DescriptionInputView {
        let optionalView = UINib(nibName: "DescriptionInputView", bundle: Bundle(for: DescriptionInputView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? DescriptionInputView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.descriptionStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.descriptionStyle.separatorStyle.lineWidth

        view.textView.textColor = style.descriptionStyle.inputStyle.color
        view.textView.font = style.descriptionStyle.inputStyle.font

        if let caretColor = style.descriptionStyle.caretColor {
            view.textView.tintColor = caretColor
        }

        view.placeholderLabel.textColor = style.descriptionStyle.placeholderStyle.color
        view.placeholderLabel.font = style.descriptionStyle.placeholderStyle.font

        view.keyboardIndicatorMode = style.descriptionStyle.keyboardIndicatorMode
        view.keyboardIndicatorIcon = style.descriptionStyle.keyboardIcon

        view.contentInsets = style.descriptionStyle.contentInsets

        return view
    }

    // MARK: Private

    private func createHeaderViewForStyle(_ style: WalletContainingHeaderStyle) -> MultilineTitleIconView {
        let view = MultilineTitleIconView()

        view.titleLabel.textColor = style.titleStyle.color
        view.titleLabel.font = style.titleStyle.font

        view.contentInsets = style.contentInsets
        view.horizontalSpacing = style.horizontalSpacing

        return view
    }

    private func createErrorViewForStyle(_ style: WalletContainingErrorStyle) -> ContainingErrorView {
        let view = ContainingErrorView()

        view.titleLabel.textColor = style.inlineErrorStyle.titleColor
        view.titleLabel.font = style.inlineErrorStyle.titleFont

        view.contentInsets = style.contentInsets
        view.horizontalSpacing = style.horizontalSpacing

        view.icon = style.inlineErrorStyle.icon

        return view
    }
}
