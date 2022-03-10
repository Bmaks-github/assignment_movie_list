//
//  CoreTypeAliases.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

public typealias Action = () -> Void
public typealias ResultHandler<T> = (Result<T, Error>) -> Void
