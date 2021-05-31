"
I should be merged into PRRichTextComposer

I am a class that provides Pillar codebloc extensions for Latex (and others in the future).

```
&
\sum_{i=1}^{n} a[i]
&
```

renders as: 
&
\sum_{i=1}^{n} a[i]
&

"
Class {
	#name : #BCCodeblockStylerExtensions,
	#superclass : #Object,
	#classInstVars : [
		'imageCache'
	],
	#category : #BeautifullComments
}

{ #category : #private }
BCCodeblockStylerExtensions class >> imageCache [
	^ imageCache ifNil: [ imageCache := LRUCache new ]
]

{ #category : #examples }
BCCodeblockStylerExtensions class >> latexExample [
	<example>
	(BCRichTextComposer new start: 
		(PRMathInTextAnnotation new 
		add: (PRText new text:
'V_i = C_0 - C_3
\frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}')))

 inspect
]

{ #category : #styling }
BCCodeblockStylerExtensions class >> latexMathStylerFor: aString [
	"<codeblockStylerFor:'latexMath'>
	
	this is totally bogus: this method does not return a styler but just an image."
	
	| expressionUrl |
	expressionUrl := 'https://latex.codecogs.com/png.latex?', aString urlEncoded.
	^self loadExternalImageFromURL: expressionUrl errorText: 'Latex error'.
]

{ #category : #private }
BCCodeblockStylerExtensions class >> loadExternalImageFromURL: aUrl errorText: errorDesc [
	"I return a Text instance with an loaded from a url"
	
	| anchoredImage |
	self flag: #cleanAndRevisit.
	anchoredImage := self imageCache 
		at: aUrl 
		ifAbsentPut: [ 
			[ anchoredImage := (String value: 1) asText
					addAttribute: (TextAnchor new anchoredMorph: (ZnEasy getPng: aUrl)).
				anchoredImage ] 
			on: Exception 
			do: [ errorDesc asText addAttribute: TextColor red ]
		].
	^ anchoredImage 
]
