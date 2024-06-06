"
I represent a preformatted paragraph indicated by '> ' at the beginning of each of my lines. 
I'm like a preformatted in HTML or Pillar '= '.
Every single line should start with '> '.

The semantics of Microdown quote block is that blocks (code blocks, headers, lists) are not interpreted inside only formatting.

In GitHub Markdown, the definitions are really complex and we do not follow them. 
	""A block quote marker consists of 0-3 spaces of initial indent, plus (a) the character > together with a following space, or (b) a single character > not followed by a space.""
"
Class {
	#name : 'MicBlockQuoteBlock',
	#superclass : 'MicContinuousMarkedBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicBlockQuoteBlock >> accept: aVisitor [
 	^ aVisitor visitQuote: self
]

{ #category : 'visiting' }
MicBlockQuoteBlock >> closeMe [
	super closeMe.
	
	children := self inlineParse: text
]

{ #category : 'testing' }
MicBlockQuoteBlock >> lineMarkup [

	^ PreformattedMarkup
]
