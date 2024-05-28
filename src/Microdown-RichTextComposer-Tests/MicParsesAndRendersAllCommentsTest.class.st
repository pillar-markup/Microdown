"
I test that rendering no class comments make microdown parser or renderer fail
"
Class {
	#name : 'MicParsesAndRendersAllCommentsTest',
	#superclass : 'TestCase',
	#category : 'Microdown-RichTextComposer-Tests-Composer',
	#package : 'Microdown-RichTextComposer-Tests',
	#tag : 'Composer'
}

{ #category : 'tests' }
MicParsesAndRendersAllCommentsTest >> testCommentFromChunkReadStream [
	"Test that we do not break on empty annotated blocks"
	Microdown asRichText: ChunkReadStream comment.
	Microdown asRichText: '!!'
]

{ #category : 'tests' }
MicParsesAndRendersAllCommentsTest >> testCommentFromFluidBuilder [
	"Test that we do not break on empty code blocks"
	Microdown asRichText: '```
```'
]

{ #category : 'tests' }
MicParsesAndRendersAllCommentsTest >> testSmokeSignalAndChoke [
	| difficultClasses |
	"this test disables error handling and tries to render all class comments in the system"
	"Really, it is a test of the robustness of Microdown parsing and rendering"
	self skip. "I take too long for normal circumstances"
	difficultClasses := OrderedCollection new.
	Smalltalk globals allClasses do: [ :cl |
			[ Microdown asRichText: cl comment ]
				on: Exception 
				do: [ difficultClasses add: cl ]
		 ].
	self assert: difficultClasses isEmpty
]
