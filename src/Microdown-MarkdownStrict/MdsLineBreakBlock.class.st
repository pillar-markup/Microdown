"
Block to process line breaks. 
"
Class {
	#name : #MdsLineBreakBlock,
	#superclass : #MicInlineElement,
	#category : #'Microdown-MarkdownStrict'
}

{ #category : #visiting }
MdsLineBreakBlock >> accept: aVisitor [

 	^ aVisitor visitLineBreak: self
]

{ #category : #accessing }
MdsLineBreakBlock >> kind [

	^ #lineBreak
]
