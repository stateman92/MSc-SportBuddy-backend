//
//  Modellable.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

protocol Modellable: Convertable {
    init(from dto: OtherForm)
    var dto: OtherForm { get }
}

extension Modellable {
    init(from otherForm: OtherForm) {
        self.init(from: otherForm)
    }

    var otherForm: OtherForm {
        dto
    }
}
