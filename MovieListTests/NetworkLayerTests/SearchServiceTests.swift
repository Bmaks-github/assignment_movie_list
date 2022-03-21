//
//  Created by Maksym Bura on 21.03.2022.
//

import Nimble
import Quick

@testable import MovieList

final class SearchServiceTests: QuickSpec {
    override func spec() {
        var subject: SearchService!
        
        beforeEach {
            subject = .init()
        }
        
        describe("when making movie search requests by movie name") {
            context("positive case - valid page number") {
                var movieSearchResult: MovieSearchResult?
                var movieSearchResultError: Error?
                
                beforeEach {
                    subject.searchMovieList(
                        movieName: "MIB",
                        page: "1"
                    ) { result in
                        switch result {
                        case .success(let movies):
                            movieSearchResult = movies
                        case .failure(let error):
                            movieSearchResultError = error
                        }
                    }
                }
                
                it("should return correct values") {
                    expect(movieSearchResult).toNotEventually(beNil())
                    expect(movieSearchResult?.page).toEventually(equal(1))
                    expect(movieSearchResult?.results?.count).toEventually(beGreaterThan(0))
                    expect(movieSearchResult?.totalPages).toEventually(beGreaterThan(0))
                    expect(movieSearchResultError).toEventually(beNil())
                }
            }
            
            context("negative case - invalid page number") {
                var movieSearchResult: MovieSearchResult?
                var movieSearchResultError: Error?
                
                beforeEach {
                    subject.searchMovieList(
                        movieName: "MIB",
                        page: "1000"
                    ) { result in
                        switch result {
                        case .success(let movies):
                            movieSearchResult = movies
                        case .failure(let error):
                            movieSearchResultError = error
                        }
                    }
                }
                
                it("should return error") {
                    expect(movieSearchResult).toEventually(beNil())
                    expect(movieSearchResultError).toNotEventually(beNil())
                }
            }
        }
    }
}
