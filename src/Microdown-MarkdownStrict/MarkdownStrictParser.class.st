"
This is a variation of the MicrodownParser that tries to be as close as possible to the ""markdown strict"" definition, that can be seen here: https://www.markdownguide.org/basic-syntax.
"
Class {
	#name : #MarkdownStrictParser,
	#superclass : #MicrodownParser,
	#category : #'Microdown-MarkdownStrict'
}

{ #category : #'node creation' }
MarkdownStrictParser >> elementBlockClasses [
		
	^ { 
	MdsRawParagraphBlock.
	 }
]

{ #category : #'node creation' }
MarkdownStrictParser >> nonMatchedBlockClassFor: line [

	^ self elementBlockClasses 
		detect: [ :each | each matches: line ]
		ifFound: [ :aClass | aClass ]
		ifNone: [ self paragraphBlockClass ]
]

{ #category : #'node creation' }
MarkdownStrictParser >> paragraphBlockClass [

	^ MdsParagraphBlock
]
