//
//  Created by Maksym Bura on 21.03.2022.
//

import Nimble
import Quick

@testable import MovieList

final class GenresServiceTests: QuickSpec {
    override func spec() {
        var subject: GenresService!
        
        beforeEach {
            subject = .init()
        }
        
        describe("when fetching genres list") {
            var movieGenresListResult: MovieGenresList?
            var movieGenresListResultError: Error?
            
            beforeEach {
                subject.getGenresList() { result in
                    switch result {
                    case .success(let genresList):
                        movieGenresListResult = genresList
                    case .failure(let error):
                        movieGenresListResultError = error
                    }
                }
            }
            
            it("should return correct values") {
                expect(movieGenresListResult).toNotEventually(beNil())
                expect(movieGenresListResult?.genres.count).toEventually(beGreaterThan(0))
                expect(movieGenresListResultError).toEventually(beNil())
            }
        }
    }
}
