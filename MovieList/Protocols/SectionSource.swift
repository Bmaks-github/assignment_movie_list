//
//  SectionSource.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

public struct SectionSource {
    public struct CellSource {
        public let model: TableViewAdaptableModelProtocol
        public let onSelectAction: Action?
        public let trailingSwipeActions: [UIContextualAction]

        public init(
            model: TableViewAdaptableModelProtocol,
            onSelectAction: Action? = nil,
            trailingSwipeActions: [UIContextualAction] = []
        ) {
            self.model = model
            self.onSelectAction = onSelectAction
            self.trailingSwipeActions = trailingSwipeActions
        }
    }

    public let cellsSources: [CellSource]
    public let headerModel: TableHeaderFooterViewAdaptableModelProtocol?
    public let footerModel: TableHeaderFooterViewAdaptableModelProtocol?

    public init(
        cellsSources: [CellSource],
        headerModel: TableHeaderFooterViewAdaptableModelProtocol? = nil,
        footerModel: TableHeaderFooterViewAdaptableModelProtocol? = nil
    ) {
        self.cellsSources = cellsSources
        self.headerModel = headerModel
        self.footerModel = footerModel
    }
}

public extension SectionSource {
    static var empty: SectionSource {
        return SectionSource(
            cellsSources: [],
            headerModel: nil,
            footerModel: nil
        )
    }
}

