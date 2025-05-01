
import Combine
import Foundation

@MainActor
class StoryViewModel  : ObservableObject {
    @Published var currentStoryImage: StoryImage
    let storyListViewModel : StoryListViewModel
    let story : Story
    private var subscribers = Set<AnyCancellable>()
    // MARK: Loom
    @Published var progress : Double = 0
    @Published private var currentStoryImageStartDate : Date? = nil
    init(storyListViewModel: StoryListViewModel, story: Story) {
        self.story = story
        self.storyListViewModel = storyListViewModel
        self.currentStoryImage = story.imageList[0]
        // MARK: Loom
        Timer.timer(0.01)
        .combineLatest($currentStoryImageStartDate)
        .sink{ _, currentStoryImageStartDate in
            // Calculate progress by comparing the currentDate, the currentStoryImageStartDate and the image duration
        }
        .store(in: &subscribers)
    }
    func next(){
        if let nextStoryImage = story.imageList.nextElement(currentStoryImage){
            currentStoryImage = nextStoryImage
        }
        else{
            storyListViewModel.nextStory()
        }
    }
    func previous(){
        if let previousStoryImage = story.imageList.previousElement(currentStoryImage){
            currentStoryImage = previousStoryImage
        }
        else{
            storyListViewModel.previousStory()
        }
    }
}

extension Timer{
    static func timer(_ seconds: Double) -> AnyPublisher<Date,Never>{
        return Timer.publish(every: seconds, on: .main, in: .default)
            .autoconnect()
            .prepend(Date.now)
            .eraseToAnyPublisher()
    }
}
