"
Block to process line breaks. 
"
Class {
	#name : 'MicLineBreakBlock',
	#superclass : 'MicInlineElement',
	#category : 'Microdown-NewMacrodown',
	#package : 'Microdown-NewMacrodown'
}

{ #category : 'visiting' }
MicLineBreakBlock >> accept: aVisitor [

 	^ aVisitor visitLineBreak: self
]

{ #category : 'accessing' }
MicLineBreakBlock >> kind [

	^ #lineBreak
]

{ #category : 'accessing' }
MicLineBreakBlock >> openingDelimiter [

	^ nil
]

{ #category : 'accessing' }
MicLineBreakBlock >> openingDelimiterSize [ 

	^ 0
]
