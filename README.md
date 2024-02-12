# cs193p
Homework exercises for the spring 2023 Stanford [CS193p](https://cs193p.sites.stanford.edu) course in SwiftUI.

## Memorize!

A few of the important concepts that I learned in this segment of the course:
- Pinning a view preview in XCode to keep it on-screen when changing scripts you are editing
- Using generics (such as `MemoryGame<CardContent> where CardContent : Equatable`) to specify that there can be multiple types as input provided that they conform to a protocal
- Using opacity to control what aspects of a view are visible, instead of a conditional, when sizing is dependent on view contents
- Using `.aspectRatio` and `minimumScaleFactor` to fit contents nicely within a view that may change sizes
- Initializing ViewModels at the `App` level as `@StateObject`, injected as `@ObservedObject` in views
- Using `protocol` to define structs that have specific properties, then binding variable types to a protocol
- Usage of `static` variables and functions, which are type functions that exist prior to initialization, don't depend on non-static variables, and are constant
- Varying associated data with different cases of enums
- That the `@ViewBuilder` annotation is necessary when a `func` or `var` generates a list of views, but not if you encapsulate a single view
- How to build a custom shape by defining a `Path`
- When a view is first visible on screen it will show with the values its initialized with, it won't animate to those values, animation only occurs when something changes in a view that is already on screen
- Using `.transition(AnyTransition.<...>)` to animate when a view enters or exits the UI
- Using `.matchedGeometry(id: Id, in: Namespace)` to animate views that move from one container to another
- Implicit `.animation` can override explicit `withAnimation { } `
- Using `.transition(.asymmetric(insertion: .identity, removal: .identity))` for when we want to override the default transition, but don't want to specify only `.transition(.identity)` which would have no transition; this works well with the `.matchedGeometry` transition
- Storing related data in tuples, i.e. `(0, causedByCardId: "")`, and unpacking with `let (amount, causedByCardId) = lastScoreChange`
- Number formating in the `Text` object, for example to show the sign of the number
- Using `Color.clear` as a placeholder for when a view has either not showed up yet, or been removed from a container, to make sure the space remains occupied

| Programming Assignment 1 | After Lecture 4                | Programming Assignment 2 | After Lecture 6                |
|--------------------------|--------------------------------|--------------------------|--------------------------------|
| ![PA1](images/pa1.png)   | ![L4](images/postLecture4.png) | ![PA2](images/pa2.png)   | ![L6](images/postLecture6.png) |
