//
//  Modellable.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

protocol Modellable: Convertible {
    /// Initialize the object from a DTO object.
    /// - Parameter from: the DTO object.
    init(from dto: OtherForm)

    /// Get the object as a DTO object.
    var dto: OtherForm { get }
}

extension Modellable {
    /// Initialize the object from an other form.
    /// - Parameter from: the other form.
    init(from otherForm: OtherForm) {
        self.init(from: otherForm)
    }

    /// Get the object as an other form.
    var otherForm: OtherForm {
        dto
    }
}
