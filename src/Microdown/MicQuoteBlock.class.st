"
I represent block markup, indicated by '> ' at the beginning of a line. 
I'm like a preformatted in HTML or Pillar '= '.
In addition every single line should starts with '> '.

In githubmarkdown the definitions are just super complex and we do not follow them. 

	""A block quote marker consists of 0-3 spaces of initial indent, plus (a) the character > together with a following space, or (b) a single character > not followed by a space.""

In addition my contents is not currently further treated but it should since

> _italic_ **bold** 

are valid.

"
Class {
	#name : #MicQuoteBlock,
	#superclass : #MicContinuousMarkedBlock,
	#category : #'Microdown-Model'
}

{ #category : #'as yet unclassified' }
MicQuoteBlock >> asPillar [

	^ PRPreformatted new
		setChildren: (self pillarFromString: text);
		yourself
]

{ #category : #testing }
MicQuoteBlock >> lineMarkup [

	^ self parser preformattedMarkup
]

{ #category : #testing }
MicQuoteBlock >> todo [
	self flag: #todo.
	"contents should be treated. see comment"
	^self 
]
