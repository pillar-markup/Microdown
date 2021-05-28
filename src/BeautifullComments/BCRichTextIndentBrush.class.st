"
I am a Brush that paints the `TextIndent` on a `Text`. The actual value of the indent is picked up from the canvas. 
"
Class {
	#name : #BCRichTextIndentBrush,
	#superclass : #BCRichTextBrush,
	#category : #BeautifullComments
}

{ #category : #paint }
BCRichTextIndentBrush >> paint: aText [	
	canvas nesting isZero ifFalse: [  
		aText addAttribute: (TextIndent tabs: canvas nesting) ]
]
