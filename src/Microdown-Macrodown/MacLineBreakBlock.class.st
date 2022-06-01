"
Block to process line breaks. 
"
Class {
	#name : #MacLineBreakBlock,
	#superclass : #MicInlineElement,
	#category : #'Microdown-Macrodown'
}

{ #category : #visiting }
MacLineBreakBlock >> accept: aVisitor [

 	^ aVisitor visitLineBreak: self
]

{ #category : #accessing }
MacLineBreakBlock >> kind [

	^ #lineBreak
]

{ #category : #accessing }
MacLineBreakBlock >> openingDelimiter [

	^ nil
]

{ #category : #accessing }
MacLineBreakBlock >> openingDelimiterSize [ 

	^ 0
]
