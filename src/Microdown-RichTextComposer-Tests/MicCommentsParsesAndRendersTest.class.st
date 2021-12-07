"
I test that rendering no class comments make microdown parser or renderer fail
"
Class {
	#name : #MicCommentsParsesAndRendersTest,
	#superclass : #TestCase,
	#category : #'Microdown-RichTextComposer-Tests-Composer'
}

{ #category : #tests }
MicCommentsParsesAndRendersTest >> testSmokeSignalAndChoke [
	| difficultClasses |
	"this test disables error handling and tries to render all class comments in the system"
	"Really, it is a test of the robustness of Microdown parsing and rendering"
	self skip. "I take too long for normal circumstances"
	difficultClasses := OrderedCollection new.
	Smalltalk globals allClasses do: [ :cl |
			[Microdown asRichText:  cl comment ]
			on: Exception 
			do: [ difficultClasses add: cl ]
		 ].
	self assert: difficultClasses isEmpty
]
