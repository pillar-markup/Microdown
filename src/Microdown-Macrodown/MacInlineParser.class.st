"
Inline parser to detect and parse extended parse functionality.

- line break with two (or more) spaces.
"
Class {
	#name : 'MacInlineParser',
	#superclass : 'MicInlineParser',
	#pools : [
		'MacConstants'
	],
	#category : 'Microdown-Macrodown',
	#package : 'Microdown-Macrodown'
}

{ #category : 'adding' }
MacInlineParser >> addLineBreakInlineBlock: indexOfAssociateOpener [
	| startIndex endIndex |
	
	startIndex := opener index + opener size.
	endIndex := string indexOf: Character cr startingAt: startIndex.
	(endIndex = 0 
		or: [ (endIndex - startIndex) = 0 ]) 
		ifTrue: [ ^ self ].

	self 
		addInlineBlock: indexOfAssociateOpener 
		from: startIndex
		to: endIndex
]

{ #category : 'private' }
MacInlineParser >> extentedDelimiters [
		
	^ { MacLineBreakDelimiter }
]

{ #category : 'actions' }
MacInlineParser >> identifyMarkupFor: aString [
	
	^ self extentedDelimiters
		detect: [ :each | each matches: aString ]
		ifFound: [ :aDelimiterClass | 
			delimiterClass := aDelimiterClass.
			aDelimiterClass applyOn: self ]
		ifNone: [ super identifyMarkupFor: aString ]
]

{ #category : 'applying' }
MacInlineParser >> processLineBreak [

	self delimiterFoundProcess.
	self addInlineBlock: (self findType: delimiterClass type).
	^ result last text size
]
