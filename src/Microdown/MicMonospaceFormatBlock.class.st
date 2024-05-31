"
I represent a monospaced text section. I'm delimited using `\`` as in `\`monospace\`` to obtain `monospace`.
"
Class {
	#name : 'MicMonospaceFormatBlock',
	#superclass : 'MicUnEvaluatedBlock',
	#instVars : [
		'children'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicMonospaceFormatBlock class >> blockName [
	^ (super blockName) withoutSuffix: 'Format'
]

{ #category : 'accessing' }
MicMonospaceFormatBlock class >> closingDelimiter [

 	^ MonospaceMarkup
]

{ #category : 'accessing' }
MicMonospaceFormatBlock class >> openingDelimiter [

 	^ MonospaceMarkup
]

{ #category : 'visiting' }
MicMonospaceFormatBlock >> accept: aVisitor [
	^ aVisitor visitMonospace: self
]

{ #category : 'accessing' }
MicMonospaceFormatBlock >> children [

	^ children
]

{ #category : 'accessing' }
MicMonospaceFormatBlock >> children: aCollection [

	children := aCollection
]

{ #category : 'accessing' }
MicMonospaceFormatBlock >> closeMe [
	"Please note that in the children we will only store text. So this could be all removed
	but at the cost of updating all the visitor that expect that the treatment on MicTextBlock will be done. 
	so for now to make sure that the tree is well formed we just store a text bloc and set correctly its parent.  Just returning the text via children was not super nice and recipe to disaster since different nodes where returned at each invocation. "
	
	super closeMe.
	self children: (Array with: (MicTextBlock new bodyString: self bodyString)).
	self children do: [ :each | each basicParent: self ].
]

{ #category : 'accessing' }
MicMonospaceFormatBlock >> text [

	^ self bodyString
]
