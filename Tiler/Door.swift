//
//  Door.swift
//  Tiler
//
//  Created by Keith Avery on 3/11/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation
class Door  {
    enum Mechanism {
        case OpensIn
        case OpensOut
        case SlidesHorizontal
        case Secret
    }
    
    enum OpenState {
        case Open, Closed
    }
    
    enum LockState {
        case Locked, Unlocked
    }
    
    var mechanism: Mechanism = .OpensIn
    var isOpen: OpenState = .Open
    var isLocked: LockState = .Unlocked
    
    
    
    init () { }
    
    convenience init (mechanism: Mechanism) {
        self.init()
        self.mechanism = mechanism
    }
    convenience init (mechanism: Mechanism, open: OpenState) {
        self.init(mechanism: mechanism)
        self.isOpen = open
    }
    
    convenience init (mechanism: Mechanism, open: OpenState, locked: LockState) {
        self.init(mechanism: mechanism, open: open)
        self.isLocked = locked
    }
    
    func open(state: OpenState = .Open) {
        self.isOpen = state
    }
    
    func close(state: OpenState = .Closed) {
        self.isOpen = state
    }
    
    func lock(state: LockState = .Locked) {
        self.isLocked = state
    }
    
    func unlock(state: LockState = .Locked) {
        self.isLocked = state
    }
    
}