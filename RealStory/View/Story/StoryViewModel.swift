
import Combine
@MainActor
class StoryViewModel  : ObservableObject {
    @Published var currentStoryImage: StoryImage
    @Published var progress : Double = 0
    let storyListViewModel : StoryListViewModel
    let story : Story
    private var subscribers = Set<AnyCancellable>()
    init(storyListViewModel: StoryListViewModel, story: Story) {
        self.story = story
        self.storyListViewModel = storyListViewModel
        self.currentStoryImage = story.imageList[0]
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

