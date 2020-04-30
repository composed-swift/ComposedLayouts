<img src="composed.png" width=20%/>

**ComposedLayouts** provides conveniences for using [Composed](http://github.com/composed-swift/composed) with `UICollectionViewCompositionalLayout` and `UICollectionViewFlowLayout`.

Since its designed primarily with `UICollectionView` in mind – it includes 2 main types:

```swift
CollectionCompositionalLayoutHandler
CollectionFlowLayoutHandler
```

However each has slightly different needs and therefore different requirements. Lets take a look at how we can work with each of them and _why_ we would want to.

##  Compositional Layout

`UICollectionViewCompositionalLayout` is generally the preferred layout to use, however if you need to support iOS <13 then you're out of luck, as such checkout the flow layout example below.

If you _can_ use the latest and greatest, then lets take a look at how you can get started:

```swift
let coordinator = CollectionCoordinator(collectionView: collectionView, sectionProvider: provider)

// we can use a convenience initializer to instantiate our layout, this takes care of all the glue-work for us.
let layout = UICollectionViewCompositionalLayout(coordinator: coordinator)

// finally just apply our layout
collectionView.setCollectionViewLayout(layout, animated: false)
```

Now we just need to conform our `Section` to  `CollectionCompositionalLayoutHandler`:

```swift
extension ContactsSection: CollectionCompositionalLayoutHandler {

    func compositionalLayoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        // return our layout section
    }

}
```

That's it! Now we can use this section inside any collection view that's using a compositional layout and know that it will look right at all times ;)

## Flow Layout

If you're using a flow layout you'll know that one of the toughest parts of working with one is building a simple table/column layout. Its not that it can't be done, but there are tiny caveates that you need to be aware of. This library attempts to remove some of those caveats and to allow you to focus on the important parts of your code instead.

First off, you can assign your layout however you want, even leave your code as is for the moment. Composed imposes no requires on either layout, but it does provide conveniences where possible.

So similary to how we'd work with a traditional approach, we simply need to conform our `Section` to `CollectionFlowLayoutHandler`:

```swift
extension ContactsSection: CollectionFlowLayoutHandler {

    func layoutMetrics(suggested: CollectionFlowLayoutMetrics, environment: CollectionFlowLayoutEnvironment) -> CollectionFlowLayoutMetrics {
        var metrics = CollectionFlowLayoutMetrics()
        metrics.contentInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
        metrics.minimumInteritemSpacing = 10
        return metrics 
    }

    func sizeForItem(at index: Int, suggested: CGSize, metrics: CollectionFlowLayoutMetrics, environment: CollectionFlowLayoutEnvironment) -> CGSize {
        // return a size for our cell
    }

}
```

Now, there are a few conveniences we can see here:

1. The `suggested` value allows us to passthrough the inherited value from UIKit or use as a reference
2. The `metrics` value provides us with all the metrics for the current section
3. The `environment` value includes additional values like the size of our `collectionView` and the current `traitCollection`

Using this information we should be able to more conveniently calculate our cell size.

## Sizing Strategy

What is we wanted columns though? We have enough data to calculate that but its such a common problem, surely Composed could solve this for you right? Right!

Introducing `CollectionFlowLayoutSizingStrategy`.

This is a convenience type that takes an optional `prototype` view, `columnCount`, `sizingMode` and the `metrics`, which you can then use to automatically calculate the appropriate size for each of your cells for you.

In order to use this however we need to refactor our code above slightly. We replace the manual sizing method, with a convenience instead:

```swift
    func sizingStrategy(at index: Int, metrics: CollectionFlowLayoutMetrics, environment: CollectionFlowLayoutEnvironment) -> CollectionFlowLayoutSizingStrategy? {
        return CollectionFlowLayoutSizingStrategy(prototype: .fromNib, columnCount: 3, sizingMode: .automatic(isUniform: true), metrics: metrics)
    }
```

That's it! Our flow layout will now size our 3 columns automatically without any additional code.

> Note: `isUniform: true` this tells the strategy to only size the first cell and then return that size for all cells. Its such a common scenario we baked it in to improve performance in those cases.
