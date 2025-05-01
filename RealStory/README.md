#  Technical Choices Explanation

## Introduction : Building Instagram-like Story

The goal of the app is to display a list of story the user can interact with like in instagram.

## "What is a Story?" : Defining Models for our App

### The Story Model

A story has list of image to display 

@Model
class Story: Identifiable, Hashable {
    var id : Int
    var imageList : [StoryImage]
    var user : User
    init(id: Int, imageList: [StoryImage], user: User) {
        self.id = id
        self.imageList = imageList
        self.user = user
    }
}
)
### Class reference type VS a struct value type : The SwiftData case

Apple has been heavely promoting struct value type so far to avoid reference type based bugs. Indeed a same reference type shared in two far away views can lead to some unexpected bugs: if modified in one view, it could unintentionally modified the value in the other view. This kind of bug is avoided with struct avlue type

However, SwiftData @Model needs to be a class. To limit the number of reference type based bugs, we can introduce some process in our code: 

- First we should use a method inspired by Facebook's' Flux principle (https://github.com/facebookarchive/flux) that every modification of the reference should
be processed through a Data Manager. Therefore in our case, every model modification should pass through SwiftData insert() method.
- Second we should cleary state that every @Model annotated class is a reprensentation of a SwiftData content. If in a view, we would like to do otherwise, a defensive copy should be make

### Generate the data from users.json

We parse the user to JsonService.userList using Decodable.load()
Then we use Story.generateStoryList(userList:) to generate a list of story to display and interact with

## Creating the Stories UI/UX with SwiftUI: A Composition of View and a Composition of State/ViewModel


### SwiftUI as a Composition of View: Reactive Programming for Swift

SwiftUI has brought Reactive Programming to iOS with a declarative way to build view. This allows us to use the composition patterns for views

struct StoryListView: View {
    @ObservedObject var storyListViewModel : StoryListViewModel
    let onClose : () -> Void
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            TabView(selection: $storyListViewModel.currentStoryId){
                if let storyList = storyListViewModel.storyList{
                    ForEach(storyList){ story in
                        StoryView(  storyListViewModel: storyListViewModel, story: story )
                            .tag(story.id)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}
 
### Beyond View Composition: SwiftUI State compostion with @ObservableObject

But as importantly, with @ObservableObject and @StateObject, it allows the Composition pattern in the state layer. This is solves React Redux monolithic problem.

Let's say we want to create the "Previous" or "Next" image or story feature on a story when the user tap on the left. 

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

We handle the next or previous tap event in StoryViewModel with next() and previous(). Since StoryViewModel has storyListViewModel as parameter just as StoryListView declared StoryView in his body, we can handle the fact that if there is no image left in the current left we pass to the next story with nextStory()

### Building new features with the right State/ViewModel composition

Let's try to build new features with this ViewModel composition

- The infinite scrolling of stories:

We would add in StoryListViewModel those two functions to update storyList if the current story is at the end of the list
        
        func handleStoryAppear( _ story : Story){
            // If story is near the end of the list, call getNextPage()
        }
        private func getNextPage(){
            // Update story list
        }
        
- The progress bar in a story:

We would add in StoryViewModel a Combine Timer a compare the current time with currentStoryImageStartDate to image duration

    @Published var progress : Double = 0
    @Published private var currentStoryImageStartDate : Date? = nil
    init(storyListViewModel: StoryListViewModel, story: Story) {
        self.story = story
        self.storyListViewModel = storyListViewModel
        self.currentStoryImage = story.imageList[0]
        Timer.timer(0.01)
        .combineLatest($currentStoryImageStartDate)
        .sink{ _, currentStoryImageStartDate in
            // Calculate progress by comparing the currentDate, the currentStoryImageStartDate and the image duration
        }
        .store(in: &subscribers)
    }


## Persistency: SwiftData as a source of truth

In this app SwiftData is the source of truth for the story list and it will handle Like and Seen Persistancy. This architecture is different from Instagram in which the source of truth is the backend. Only on the device are saved if a story is seen or not as when we delete Instragam and reinstall it, the seen story are now marked as unseen. It is a smart way for them to save backend space as Seen story are not critical data and can be saved on device.

### Loading users.json generated StoryList to SwiftData

We load the mock storyList generated from users.json to SwiftData on launch in StoryService

StoryService

    static func resetData(){
        SwiftDataService.deleteAll()
        StoryService.save(storyList: Story.testStoryList)
    }

### Linking SwiftData to the State/ViewModel Layer

We use a ViewModifier SyncWithView to link StoryListViewModel.storyList to SwiftData @Query. It is an elegant way to link the state layer to SwiftData as we here use a ViewModifier beyond its usual function of styling Views.

    extension StoryListManager{
        struct SyncWithView: ViewModifier {
            @ObservedObject var storyListViewModel : StoryListViewModel
            @Query( sort: \Story.id) var storyList: [Story]
            func body(content: Content) -> some View {
                      content.onAppear{
                          storyListViewModel.storyList = storyList
                    }
                    .onChange(of: storyList){ storyList in
                        storyListViewModel.storyList = storyList
                    }
                }
        }
    }
     
## Lool Link

https://www.loom.com/share/dc29e069cca24735a7bd62b08d2a0f38
