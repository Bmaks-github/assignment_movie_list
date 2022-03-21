//
//  Created by Maksym Bura on 11.03.2022.
//

import Nimble
import Quick

@testable import MovieList

final class MovieDetailViewModelTests: QuickSpec {
    override func spec() {
        var subject: MovieDetailViewModel!
        var view: MovieDetailViewProtocolMock!
        var router: MovieDetailRouterProtocolMock!
        var worker: MovieParamsParserProtocolMock!
        
        beforeEach {
            view = .init()
            router = .init()
            worker = .init()
            subject = createSubject()
        }
        
        describe("when view is loaded") {
            let movieDetail = TestData.movieSearchResultDemo.results?.first!
            
            beforeEach {
                worker.getImageUrlForReturnValue = .init(string: "https://demo.ua")
                subject.viewLoaded()
            }
            
            it("should update the view") {
                expect(view.updateWithCallsCount).to(equal(1))
            }
            
            it("should update the view with correct data") {
                expect(view.updateWithReceivedModel!.title).to(equal(movieDetail?.title))
                expect(view.updateWithReceivedModel!.rightNavBarText).to(equal("9.0 🏆"))
                expect(view.updateWithReceivedModel!.viewModel.overviewText).to(equal(movieDetail?.overview))
                expect(view.updateWithReceivedModel!.viewModel.posterImageUrl).toNot(beNil())
            }
        }
        
        func createSubject() -> MovieDetailViewModel {
            let viewModel = MovieDetailViewModel(
                router: router,
                worker: worker,
                movieDetail: TestData.movieSearchResultDemo.results!.first!
            )
            viewModel.view = view
            return viewModel
        }
    }
}

private extension MovieDetailViewModelTests {
    enum TestData {
        static let searchBarTextDemo = "Mortal Kombat"
        
        static let movieGenreListDemo = MovieGenresList(
            genres:
                [MovieGenre(id: 1, name: "Horror")]
        )
        
        static let movieSearchResultDemo = MovieSearchResult(
            page: 1,
            totalResults: 20,
            totalPages: 2,
            results: [MovieDetail(
                id: 1,
                adult: true,
                overview: "overview",
                genreIds: [1],
                originalTitle: "Original title",
                originalLanguage: "Original language",
                title: "Title",
                popularity: 8.0,
                voteCount: 234,
                video: false,
                voteAverage: 9.0,
                posterPath: "/path",
                releaseDate: nil,
                backdropPath: "/backdrop_path"
            )]
        )
    }
}
