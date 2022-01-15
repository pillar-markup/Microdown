"
I am a presenter for formatted text (class Text).
I am a read-only presenter. There is no rich text editor, rich text is often composed using microdown.

The text to present is set by `text:` method.

I allow access to the currently selected text. 

I can be in wrap mode (default) or not. Once created this cannot be changed. In no-wrap-mode images are not resized when I change size.

## Implementation
I work together with `SpMorphicRichTextAdapter` and `SpRichTextMorph`. The morph is a subclass of `RubScrolledTextMorph`. My class side method adapterName specifies my adapter, and the buildWidget method of the adapter builds the morph.

I support `MicScalingTextAnchor`. When the size of the morph changes, the morph calls my render method. I then rescale the scaleable images (if any). As I am read-only, the location of the scalable images do not change, and I keep a list of the indexes where they are in `imageIndexes`. imageIndexes are computed in `text:`.
"
Class {
	#name : #MicTextPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#text => ObservableSlot',
		'#scalingImageIndexes',
		'#selection => ObservableSlot',
		'#wrapWord => ObservableSlot'
	],
	#category : #'Microdown-RichTextPresenter'
}

{ #category : #specs }
MicTextPresenter class >> adapterName [

	^ #MicMorphicTextAdapter
]

{ #category : #examples }
MicTextPresenter class >> cheetSheet [
^ Microdown parse: '# Markdown Cheatsheet

% adapted from https://raw.githubusercontent.com/tchapi/markdown-cheatsheet/master/README.md

<?columns
<?column
# Heading 1

   >    Markup :  `# Heading 1`

## Heading 2

   >    Markup :  `## Heading 2`

### Heading 3 ###

   >    Markup :  `### Heading 3`

#### Heading 4-6

   >    Markup :  ####(##) Heading 4-6

?>

<?column
_Emphasized text_

   >    Markup :  `_Emphasized text_`

**Strong text**

   > Markup :  **Strong text**

**__Strong emphasized text__**

   >   Markup :  `**__Strong emphasized text__**`

[Named Link](http://www.google.fr/ "Named link title") 

   > Markup :  `[Named Link](http://www.google.fr/ "Named link title")`

[heading-1](#heading-1)
    
   > Markup: `[heading-1](#heading-1)`
?>
?>

Table, like this one :


|First Header | Second Header|
|-------------| -------------|
|Content Cell | Content Cell |
|Content Cell | Content Cell |


```
|First Header | Second Header|
|-------------| -------------|
|Content Cell | Content Cell |
|Content Cell | Content Cell |
```



`boxed code()`

   >    Markup :  `boxed code()`


### source code with highlights

```smalltalk
toggleRendering
	rendering := rendering not.
	self update
```

    >   Markup : 
 
```text
    ```pharo
    toggleRendering
	   rendering := rendering not.
	   self update
	```
```
 

### Lists

* Bullet list
    * Nested bullet
        * Sub-nested bullet etc
* Bullet list item 2

```text
* Bullet list
    * Nested bullet
        * Sub-nested bullet etc
* Bullet list item 2

or

- Bullet list
    - Nested bullet
        - Sub-nested bullet etc
- Bullet list item 2 
```

1. A numbered list
    1. A nested numbered list
    2. Which is numbered
2. Which is numbered

```text
1. A numbered list
   1. A nested numbered list
   2. Which is numbered
2. Which is numbered
```

### block quotes
   > Blockquote
   > > Nested blockquote

```text
> Blockquote
>   > Nested Blockquote
```

_Horizontal line :_
- - - -

    Markup :  - - - -

### Images
_Image with alt :_

![picture alt](http://via.placeholder.com/200x150 "Caption is optional")


    Markup : ![picture alt](http://via.placeholder.com/200x150 optionalArguments)

The optional arguments are a pharo speciality. It is of the form `arg1=value1&arg2=value2...`. The arguments are used differently by the different renderers. The rich text render uses `width` in pixels to scale the image.
'
]

{ #category : #examples }
MicTextPresenter class >> exampleCheetSheet [
	<example>
	^ self new
		text: ( Microdown asRichText: self cheetSheet  );
		openWithSpec
]

{ #category : #examples }
MicTextPresenter class >> exampleSample [
	<example>
	^ self new
		text: ( Microdown asRichText: self sampleDocument   );
		openWithSpec
]

{ #category : #examples }
MicTextPresenter class >> sampleDocument [
	"I return a sample document"
	^ Microdown parse: '# Header 1
## Header 2
### Header 3
This is just first line with an inline web ref [Pharo](http://pharo.org/)

![](https://pharo.org/web/files/pharo.png width=75%)

Here are direct links to classes and method
- `String`
- `String>>#trim`

And this is another line'
]

{ #category : #api }
MicTextPresenter >> enabled: aBoolean [
	"Set if the widget is enabled (clickable or focusable)"

	super enabled: aBoolean.
	self changed: #enabled: with: { aBoolean }
]

{ #category : #initialization }
MicTextPresenter >> initialize [
	super initialize.
	text := '' asText.
	scalingImageIndexes := Array new.
]

{ #category : #testing }
MicTextPresenter >> isWrapWord [
	"Answer true if words will be wrapped to make text fit horizontally into component area."

	^ wrapWord
]

{ #category : #selection }
MicTextPresenter >> rawSelection: anInterval [

	self property: #selection rawValue: anInterval
]

{ #category : #accessing }
MicTextPresenter >> renderWidth: renderWidth [
	"I am called by the morph directly to recompute image sizes"
	adapter ifNil: [ ^self ]. "I can be asked to render during setup"
	scalingImageIndexes  do: [ :idx | 
		(text attributeAt: idx ofKind: MicScalingTextAnchor) targetWidth: renderWidth ].
]

{ #category : #selection }
MicTextPresenter >> selectAll [
	self selectionInterval: (1 to: text size)
]

{ #category : #selection }
MicTextPresenter >> selectNone [
	self selectionInterval: (1 to: 0)
]

{ #category : #selection }
MicTextPresenter >> selectedText [ 
	"Answer the text contained in selection interval 
	(See `SpAbstractTextPresenter>>#selectionInterval`)"
	| selectionInterval |
	
	selectionInterval := self selectionInterval.
	selectionInterval ifEmpty: [ ^ '' asText ].
	
	^ self text
		copyFrom: selectionInterval first 
		to: selectionInterval last
]

{ #category : #selection }
MicTextPresenter >> selectionInterval [
	"Answer the text selection interval (an interval from start to end)."
	
	self withAdapterDo: [ :anAdapter | 
		self property: #selection rawValue: anAdapter selectionInterval].
	^ selection ifNil: [ 1 to: 0 ]
]

{ #category : #selection }
MicTextPresenter >> selectionInterval: anInterval [
	"Set the text selection interval.
	 `anInterval` is an `Interval` from the first character selected to the end."
	
	selection := anInterval.
	adapter selectionInterval: anInterval
	
]

{ #category : #accessing }
MicTextPresenter >> text [

	^ text
]

{ #category : #accessing }
MicTextPresenter >> text: aText [
	text := aText asText "just in case I was given a string".
	scalingImageIndexes := (1 to: text size) 
		select: [ :idx | 
			((text at: idx) = Character home) 
			and: [ (text attributeAt: idx ofKind: MicScalingTextAnchor) notNil ] ].
	self withAdapterDo: [ adapter setText: aText ]
	
]

{ #category : #enumerating }
MicTextPresenter >> whenSelectionChangedDo: aBlock [
	"Inform when selection changed. 
	 `aBlock` receives two optional arguments 
	 - new selection
	 - old selection"

	self property: #selection whenChangedDo: aBlock
]

{ #category : #api }
MicTextPresenter >> whenTextChangedDo: aBlock [
	"Inform when text has been changed (`text:` has been called)
	 `aBlock` receives two optional arguments 
	 - new text
	 - old text"

	self property: #text whenChangedDo: aBlock
]
