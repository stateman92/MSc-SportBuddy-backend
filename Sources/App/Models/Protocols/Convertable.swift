//
//  Convertable.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

protocol Convertable {
    associatedtype OtherForm

    init(from otherForm: OtherForm)
    var otherForm: OtherForm { get }
}
