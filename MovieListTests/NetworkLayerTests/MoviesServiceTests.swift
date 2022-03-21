//
//  Created by Maksym Bura on 21.03.2022.
//

import Nimble
import Quick

@testable import MovieList

final class MoviesServiceTests: QuickSpec {
    override func spec() {
        var subject: MoviesService!
        
        beforeEach {
            subject = .init()
        }
        
        describe("when fetching popular movies list") {
            context("positive case - valid page number") {
                var moviesResult: MovieSearchResult?
                var moviesResultError: Error?
                
                beforeEach {
                    subject.getPopularMovies(
                        page: "1"
                    ) { result in
                        switch result {
                        case .success(let movies):
                            moviesResult = movies
                        case .failure(let error):
                            moviesResultError = error
                        }
                    }
                }
                
                it("should return correct values") {
                    expect(moviesResult).toNotEventually(beNil())
                    expect(moviesResult?.page).toEventually(equal(1))
                    expect(moviesResult?.results?.count).toEventually(beGreaterThan(0))
                    expect(moviesResult?.totalPages).toEventually(beGreaterThan(0))
                    expect(moviesResultError).toEventually(beNil())
                }
            }
            
            context("negative case - invalid page number") {
                var moviesResult: MovieSearchResult?
                var moviesResultError: Error?

                beforeEach {
                    subject.getPopularMovies(
                        page: "1000"
                    ) { result in
                        switch result {
                        case .success(let movies):
                            moviesResult = movies
                        case .failure(let error):
                            moviesResultError = error
                        }
                    }
                }
                
                it("should return error") {
                    expect(moviesResult).toEventually(beNil())
                    expect(moviesResultError).toNotEventually(beNil())
                }
            }
        }
    }
}
