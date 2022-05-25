"
When a raw is detected, the inline parser answer raw blocks.
"
Class {
	#name : #MdsRawInlineParser,
	#superclass : #MicInlineParser,
	#category : #'Microdown-MarkdownStrict'
}

{ #category : #'instance creation' }
MdsRawInlineParser >> elementBlockClass [

	^ MicRawBlock
]
