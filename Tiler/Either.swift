//
//  Either.swift
//  Tiler
//
//  Created by Keith Avery on 3/14/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

public enum Either<T1,T2> {
    case Left(T1)
    case Right(T2)
}