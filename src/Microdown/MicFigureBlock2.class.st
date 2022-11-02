"
I am a **figure**.

My syntax is: `![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png  ""anchor=figanchor&width=80"")`

You should get the following picture: 
![Here is a nice caption.](https://files.pharo.org/media/logo/logo.png ""anchor=figanchor&width=80"")

I have a resources, i.e. an object referencing either a file (in relative or absolute manner) or an Url, that refers to a given image object.

What is important to see is that there is a space between the url arguments and microdown arguments. 
"
Class {
	#name : #MicFigureBlock2,
	#superclass : #MicInlineBlockWithUrl2,
	#category : #'Microdown-InlineParser'
}

{ #category : #visiting }
MicFigureBlock2 >> accept: aVisitor [
 	^ aVisitor visitFigure: self
]
