//
//  SectionSource.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

import UIKit

struct SectionSource {
    struct CellSource {
        let model: TableViewAdaptableModelProtocol
        let onSelectAction: Action?
        let trailingSwipeActions: [UIContextualAction]

        init(
            model: TableViewAdaptableModelProtocol,
            onSelectAction: Action? = nil,
            trailingSwipeActions: [UIContextualAction] = []
        ) {
            self.model = model
            self.onSelectAction = onSelectAction
            self.trailingSwipeActions = trailingSwipeActions
        }
    }

    let cellsSources: [CellSource]
    let headerModel: TableHeaderFooterViewAdaptableModelProtocol?
    let footerModel: TableHeaderFooterViewAdaptableModelProtocol?

    init(
        cellsSources: [CellSource],
        headerModel: TableHeaderFooterViewAdaptableModelProtocol? = nil,
        footerModel: TableHeaderFooterViewAdaptableModelProtocol? = nil
    ) {
        self.cellsSources = cellsSources
        self.headerModel = headerModel
        self.footerModel = footerModel
    }
}

extension SectionSource {
    static var empty: SectionSource {
        return SectionSource(
            cellsSources: [],
            headerModel: nil,
            footerModel: nil
        )
    }
}

