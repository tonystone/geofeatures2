/*
 *   CoordinateReferenceSystem.swift
 *
 *   Copyright 2016 Tony Stone
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 *   Created by Tony Stone on 2/5/16.
 */
import Swift

/** 
 Coordinate System Types

 These are used by the algorythms when they are applyed to the types
*/
public protocol CoordinateReferenceSystem {}

public struct Cartesian: CoordinateReferenceSystem {
    public init() {}
}

@available(*, unavailable, message: "currently not supported")
public struct Ellipsoidal: CoordinateReferenceSystem {}

@available(*, unavailable, message: "currently not supported")
public struct Spherical: CoordinateReferenceSystem {}

@available(*, unavailable, message: "currently not supported")
public struct Vertical: CoordinateReferenceSystem {}

@available(*, unavailable, message: "currently not supported")
public struct Polar: CoordinateReferenceSystem {}