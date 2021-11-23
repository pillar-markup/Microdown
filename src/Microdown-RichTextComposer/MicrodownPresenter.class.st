Class {
	#name : #MicrodownPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'text',
		'document',
		'textMorph'
	],
	#category : #'Microdown-RichTextComposer'
}

{ #category : #'as yet unclassified' }
MicrodownPresenter class >> cheetSheet [
^'# Markdown Cheatsheet
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

{ #category : #specs }
MicrodownPresenter class >> defaultSpec [
	 ^ SpBoxLayout newTopToBottom
			add: #textMorph;
			yourself
]

{ #category : #'instance creation' }
MicrodownPresenter class >> open [
	<script>
	(self on: self cheetSheet ) openWithSpec 
]

{ #category : #'instance creation' }
MicrodownPresenter class >> sampleDocument [
	"I return a sample document"
	^ Microdown parse: '### Links
This is just first line with an inline web ref [Pharo](http://pharo.org/)

[![](https://pharo.org/web/files/pharo.png width=75%)](http://pharo.org/)

Here are direct links to classes and method
- `String`
- `String>>#trim`

And this is another line'
]

{ #category : #initialization }
MicrodownPresenter >> announceDisplayed [
	"I am a hook method called by SpWindowPresenter when I am finally shown"
	"textMorph morph setText: self text"
]

{ #category : #accessing }
MicrodownPresenter >> document [

	^ document
]

{ #category : #accessing }
MicrodownPresenter >> document: aNode [

	document := aNode.
	text := Microdown asRichText: document 
		
]

{ #category : #initialization }
MicrodownPresenter >> initializePresenters [

	super initializePresenters.
	textMorph  := self newMorph
		morph: (MicTextMorph new
			beWrapped;
			hResizing: #spaceFill; 
			vResizing: #spaceFill;
			in: [ :this | this textArea readOnly: true ];
			yourself);
		yourself.
	"Crude check, but it seems to work. Problem is that the whole document is re-rendered"
	textMorph morph textAreaChanged: [ self render ]




]

{ #category : #initialization }
MicrodownPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter 
		initialExtent: 800@500;
		title: 'Microdown presenter'
]

{ #category : #initialization }
MicrodownPresenter >> parserClass [ 
	^ MicroDownParser
]

{ #category : #initialization }
MicrodownPresenter >> render [
	|renderWidth imageIndexes|
	renderWidth := textMorph morph width.
	"for really large documents, the imageIndexes could be cached, and only changed when a new document is shown"
	imageIndexes := ((1 to: text size) select: [ :idx | (text at: idx) = Character home ]).
	imageIndexes do: [ :idx | 
		(text attributesAt: idx) 
			detect: [ :attr | attr isKindOf: MicScalingTextAnchor  ] 
			ifFound: [:micTextAnchor| micTextAnchor targetWidth: renderWidth ]].
	textMorph morph setText: text
]

{ #category : #accessing }
MicrodownPresenter >> scrollTo: aString [
	"select the first occurance of aString and scroll so it is shown"
]

{ #category : #accessing }
MicrodownPresenter >> setModelBeforeInitialization: aNode [

	self document: aNode
]

{ #category : #accessing }
MicrodownPresenter >> text [
	^ text
]
