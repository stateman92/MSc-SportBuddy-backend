//
//  Convertible.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

/// A common protocol for objects that are convertible to and from an other form.
protocol Convertible {
    /// The other form's type.
    associatedtype OtherForm

    /// Initialize the object from an other form.
    /// - Parameter otherForm: the other form.
    init(from otherForm: OtherForm)

    /// Get the object as an other form.
    var otherForm: OtherForm { get }
}
