"
This is a variation of the MicrodownParser that tries to be as close as possible to the ""markdown strict"" definition, that can be seen here: https://www.markdownguide.org/basic-syntax.
"
Class {
	#name : #MacrodownParser,
	#superclass : #MicrodownParser,
	#category : #'Microdown-Macrodown'
}

{ #category : #public }
MacrodownParser >> blockStarterClassFrom: line [

	self flag: #HACK. "This is a special case because it collides with environment"
	(MacRawParagraphBlock matchesComment: line) 
		ifTrue: [ ^ self nonMatchedBlockClassFor: line ]. 
		
	^ super blockStarterClassFrom: line
]

{ #category : #'node creation' }
MacrodownParser >> elementBlockClasses [
		
	^ { 
	MacRawParagraphBlock.
	 }
]

{ #category : #'node creation' }
MacrodownParser >> nonMatchedBlockClassFor: line [

	^ self elementBlockClasses 
		detect: [ :each | each matches: line ]
		ifFound: [ :aClass | aClass ]
		ifNone: [ self paragraphBlockClass ]
]

{ #category : #'node creation' }
MacrodownParser >> paragraphBlockClass [

	^ MacParagraphBlock
]
