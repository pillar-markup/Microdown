"
I am a **figure**.

My syntax is: `![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png  ""anchor=figanchor&width=80"")`

You should get the following picture: 
![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png ""anchor=figanchor&width=80"")

I have a resource, i.e. an object referencing either a file (in relative or absolute manner), or an URL that refers to a given image object.

What is important to see is that there is a space between the URL argument and microdown arguments. 
"
Class {
	#name : 'MicFigureBlock',
	#superclass : 'MicInlineBlockWithUrl',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
MicFigureBlock class >> closingDelimiter [

 	^ NameCloserUrlOpener
]

{ #category : 'accessing' }
MicFigureBlock class >> openingDelimiter [
  
    ^ FigureNameOpenerMarkup
]

{ #category : 'visiting' }
MicFigureBlock >> accept: aVisitor [
 	^ aVisitor visitFigure: self
]

{ #category : 'accessing' }
MicFigureBlock >> altText [
	^ (self children collect: #plainText) joinUsing: ' '
]

{ #category : 'visiting' }
MicFigureBlock >> closeMe [

	super closeMe.
	self children do: [ :each | each basicParent: self ].
]

{ #category : 'testing' }
MicFigureBlock >> hasCaption [
	
	^ children isNotNil 
]

{ #category : 'printing' }
MicFigureBlock >> plainText [
	^ '![', ((self children collect: #plainText) joinUsing: ' '), '](', url ,')'
]
