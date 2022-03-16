//
//  Created by Maksym Bura on 10.03.2022.
//
import Nimble
import Quick

@testable import MovieList

final class MovieListViewModelTests: QuickSpec {
    override func spec() {
        var subject: MovieListViewModel!
        var view: MovieListViewProtocolMock!
        var router: MovieListRouterProtocolMock!
        var worker: MovieListWorkerProtocolMock!
        var genresService: GenresServiceProtocolMock!
        var movieListPaginator: MovieListPaginatorProtocolMock!
        
        beforeEach {
            view = .init()
            router = .init()
            worker = .init()
            genresService = .init()
            movieListPaginator = .init()
            subject = createSubject()
        }
        
        describe("when view is loaded") {
            beforeEach {
                movieListPaginator.fetchFirstMoviesCompletionClosure = { $0(.success(TestData.movieSearchResultDemo.results!)) }
                worker.getGenreNamesListForGenresListReturnValue = TestData.demoGenreList
                worker.getMarkBarValueMarkReturnValue = TestData.demoMarkBarValue
                worker.getImageUrlForReturnValue = TestData.demoImageUrl
                genresService.getGenresListCompletionClosure = { $0(.success(TestData.movieGenreListDemo)) }
                
                subject.viewLoaded()
            }
            
            it("should fetch genres list") {
                expect(genresService.getGenresListCompletionCallsCount).to(equal(1))
            }
            
            it("should fetch popular movies and update the view") {
                expect(movieListPaginator.fetchFirstMoviesCompletionCallsCount).to(equal(1))
            }
            
            it("should update the view") {
                expect(view.updateWithCallsCount).toEventually(equal(1), timeout: .seconds(1))
                expect(view.updateWithReceivedState).toEventually(equal(.hasData), timeout: .seconds(1))
            }
            
            it("should call loader") {
                expect(view.setLoadingCallsCount).toEventually(equal(4), timeout: .seconds(1))
            }
            
            it("should have valid data") {
                expect((subject.sections.first!.cellsSources.first!.model as! MovieListTableViewCell.Model).title)
                    .toEventually(equal(TestData.movieSearchResultDemo.results?.first?.title), timeout: .seconds(1))
                
                expect((subject.sections.first!.cellsSources.first!.model as! MovieListTableViewCell.Model).genre)
                    .toEventually(equal(TestData.demoGenreList.uppercased()), timeout: .seconds(1))
                
                expect((subject.sections.first!.cellsSources.first!.model as! MovieListTableViewCell.Model).mark)
                    .toEventually(equal("9.0"), timeout: .seconds(1))
                
                expect((subject.sections.first!.cellsSources.first!.model as! MovieListTableViewCell.Model).imageUrl)
                    .toNotEventually(beNil(), timeout: .seconds(1))

                expect((subject.sections.first!.cellsSources.first!.model as! MovieListTableViewCell.Model).markBarValue)
                    .toEventually(equal(TestData.demoMarkBarValue), timeout: .seconds(1))
            }
        }
        
        describe("when search bar text changed") {
            beforeEach {
                movieListPaginator.fetchFirstMoviesCompletionClosure = { $0(.success(TestData.movieSearchResultDemo.results!)) }
                worker.getGenreNamesListForGenresListReturnValue = "HORROR"
                worker.getMarkBarValueMarkReturnValue = 8.0
                
                subject.searchBarTextChanged(text: TestData.searchBarTextDemo)
            }
            
            it("should call movie search service method") {
                expect(movieListPaginator.fetchFirstMoviesCompletionCallsCount).toEventually(equal(1), timeout: .seconds(1))
            }
            
            it("should set appropriate search filter") {
                expect(movieListPaginator.selectModeModeCallsCount).toEventually(equal(1), timeout: .seconds(1))
                expect(movieListPaginator.selectModeModeReceivedMode).toEventually(equal(.searchMovie(TestData.searchBarTextDemo)), timeout: .seconds(1))
            }
            
            it("should update the view") {
                expect(view.updateWithCallsCount).toEventually(equal(1), timeout: .seconds(1))
            }
        }
        
        describe("when user scrolled to the last item in table view") {
            beforeEach {
                movieListPaginator.fetchFirstMoviesCompletionClosure = { $0(.success(TestData.movieSearchResultDemo.results!)) }
                movieListPaginator.fetchNextMoviesCompletionClosure = { $0(.success(TestData.movieSearchResultDemo.results!)) }
                worker.getGenreNamesListForGenresListReturnValue = "HORROR"
                worker.getMarkBarValueMarkReturnValue = 8.0

                subject.searchBarTextChanged(text: TestData.searchBarTextDemo)
                subject.requestedMoreMovies()
            }
            
            it("should call movie search service method with next page") {
                expect(movieListPaginator.fetchNextMoviesCompletionCallsCount).toEventually(equal(1), timeout: .seconds(1))
            }
            
            it("should update the view") {
                expect(view.updateWithCallsCount).toEventually(equal(2), timeout: .seconds(1))
            }
        }
        
        func createSubject() -> MovieListViewModel {
            let viewModel = MovieListViewModel(
                router: router,
                worker: worker,
                genresService: genresService,
                movieListPaginator: movieListPaginator
            )
            viewModel.view = view
            return viewModel
        }
    }
}

private extension MovieListViewModelTests {
    enum TestData {
        static let demoGenreList = "Horror"
        static let demoMarkBarValue: Float = 0.8
        static let demoImageUrl = URL(string: "https://demo.ua")
        
        static let searchBarTextDemo = "Mortal Kombat"
        
        static let movieGenreListDemo = MovieGenresList(
            genres:
                [MovieGenre(id: 1, name: "Horror")]
        )
        
        static let movieSearchResultDemo = MovieSearchResult(
            page: 1,
            results: [MovieDetail(
                posterPath: "/path",
                adult: true,
                overview: "overview",
                releaseDate: nil,
                genreIds: [1],
                id: 1,
                originalTitle: "Original title",
                originalLanguage: "Original language",
                title: "Title",
                backdropPath: "/backdrop_path",
                popularity: 8.0,
                voteCount: 234,
                video: false,
                voteAverage: 9.0
            )],
            totalResults: 20,
            totalPages: 2
        )
    }
}
