//
//  Created by Maksym Bura on 16.03.2022.
//

import Nimble
import Quick

@testable import MovieList

final class MovieListWorkerTests: QuickSpec {
    override func spec() {
        var subject: MovieListWorker!
        
        beforeEach {
            subject = .init()
        }
        
        describe(".getGenreNamesList") {
            var genreNamesList = ""
            
            beforeEach {
                genreNamesList = subject.getGenreNamesList(for: TestData.genreNamesListIds, genresList: TestData.movieGenreList)
            }
            
            it("should construct correct genre names list") {
                expect(genreNamesList).to(equal("Horror, Sci-fi, Fantasy"))
            }
        }
        
        describe(".getGenreNamesList") {
            var genreNamesList = ""
            
            beforeEach {
                genreNamesList = subject.getGenreNamesList(for: TestData.genreNamesListIds, genresList: TestData.movieGenreList)
            }
            
            it("should construct correct genre names list") {
                expect(genreNamesList).to(equal("Horror, Sci-fi, Fantasy"))
            }
        }
        
        describe(".getImageUrl") {
            var imageUrl: URL? = nil
            
            beforeEach {
                imageUrl = subject.getImageUrl(for: TestData.imagePath)
            }
            
            it("should construct correct image URL") {
                expect(imageUrl?.absoluteString).to(equal("https://image.tmdb.org/t/p/w1280\(TestData.imagePath)"))
            }
        }
        
        describe(".getMarkBarValue") {
            var markBarValue: Float? = nil
            
            beforeEach {
                markBarValue = subject.getMarkBarValue(mark: TestData.mark)
            }
            
            it("should construct mark bar value") {
                expect(markBarValue).to(equal(0.8))
            }
        }
    }
}

private extension MovieListWorkerTests {
    enum TestData {
        static let mark: Double = 8.0
        static let imagePath: String = "/12345"
        static let genreNamesListIds: [Int] = [1, 2, 3]
        static let movieGenreList: MovieGenresList = .init(
            genres: [
                .init(id: 1, name: "Horror"),
                .init(id: 2, name: "Sci-fi"),
                .init(id: 3, name: "Fantasy")
            ]
        )
    }
}
