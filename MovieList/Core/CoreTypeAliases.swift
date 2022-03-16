//
//  CoreTypeAliases.swift
//  MovieList
//
//  Created by Maksym Bura on 07.03.2022.
//

typealias Action = () -> Void
typealias ResultHandler<T> = (Result<T, Error>) -> Void
