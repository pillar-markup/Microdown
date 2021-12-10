"
I am a presenter for formatted text (class Text).
I am a read-only presenter. There is no rich text editor, rich text is often composed using microdown.

I support MicScalingTextAnchor. 
I keep a list of the indexes where they are in `imageIndexes`. imageIndexes are computed in `text:`
"
Class {
	#name : #SpRichTextPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'text',
		'scalingImageIndexes'
	],
	#category : #'Microdown-RichTextComposer-Presenter'
}

{ #category : #specs }
SpRichTextPresenter class >> adapterName [

	^ #SpMorphicRichTextAdapter
]

{ #category : #'as yet unclassified' }
SpRichTextPresenter class >> cheetSheet [
^Microdown parse: '# Markdown Cheatsheet

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
SpRichTextPresenter class >> example [
	<example>
	self new
		text: (Microdown asRichText: self sampleDocument   );
		openWithSpec
]

{ #category : #'instance creation' }
SpRichTextPresenter class >> sampleDocument [
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

{ #category : #'widget API' }
SpRichTextPresenter >> codePaneMenu: aMenu shifted: shifted [

	| menuPresenter | 
	menuPresenter := SpMenuPresenter new.
	^ SpBindings
		  value: self application adapterBindings
		  during: [ menuPresenter value buildWithSpec ]
]

{ #category : #accessing }
SpRichTextPresenter >> render [
	|renderWidth |
	adapter ifNil: [ ^self ]. "I can be asked to render during setup"
	
	renderWidth := adapter widget width.
	scalingImageIndexes  do: [ :idx | 
		(text attributeAt: idx ofKind: MicScalingTextAnchor) targetWidth: renderWidth ].
	self adapter widget resetState
]

{ #category : #accessing }
SpRichTextPresenter >> text [

	^ text
]

{ #category : #accessing }
SpRichTextPresenter >> text: aText [
	text := aText asText "just in case I was given a string".
	scalingImageIndexes := (1 to: text size) 
		select: [ :idx | 
			((text at: idx) = Character home) 
			and: [ (text attributeAt: idx ofKind: MicScalingTextAnchor) notNil ] ].
	
]
