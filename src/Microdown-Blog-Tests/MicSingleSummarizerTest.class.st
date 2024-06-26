Class {
	#name : 'MicSingleSummarizerTest',
	#superclass : 'TestCase',
	#instVars : [
		'micSingleSummarizer',
		'resources'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'fixture' }
MicSingleSummarizerTest >> createMicRootBlock [

	| micRootBlock |
	micRootBlock := Microdown parse:
		                resources generateFilesystemExample contents.
	^ micRootBlock fromFile: resources generateFilesystemExample
]

{ #category : 'running' }
MicSingleSummarizerTest >> setUp [

	super setUp.
	resources := MicFileTestResources new.
	micSingleSummarizer := MicSingleSummarizer new.
	micSingleSummarizer targetDirectory: '/html/' asFileReference.
	
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testContents [

	| root dumper |
	root := MicRealDumper new visit:
		        (micSingleSummarizer summarize: self createMicRootBlock).
	dumper := Microdown parse:
		          '# [A Cool Story](' , '' , '/anExample1.html' , '' , ')
	Pharo is cool but this is a superlong paragraph Simple powerful language: No constructors, no...'.

	dumper := MicRealDumper new visit: dumper.

	self assert: root contents equals: dumper contents
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testFirstHeaderBlockOf [

	| header |
	
	header := MicSingleSummarizer new firstHeaderBlockOf: self createMicRootBlock.
	self assert: ( header isKindOf: MicHeaderBlock).
	self assert: header text equals: 'A Cool Story'.
	
	self assert: (header headerElements collect: [:each | each plainText ]) asArray equals: #('A Cool Story').
	header headerElements do: [ :each | self assert: each parent equals: header ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testFirstHeaderBlockOfWithNoHeader [

	| header |
	header := micSingleSummarizer firstHeaderBlockOf: (Microdown parse:
			           resources generateFilesystemExampleEmpty asFileReference
				           contents).
	self assert: (header isKindOf: MicHeaderBlock).
	self assert: header text equals: 'Please define a header'.

	self
		assert:
		(header headerElements collect: [ :each | each plainText ]) asArray
		equals: #( 'Please define a header' ).
	header headerElements do: [ :each |
		self assert: each parent equals: header ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testFirstParagraphBlockOf [

	| paragraph |
	paragraph := micSingleSummarizer
		             maximumWords: 3;
		             firstParagraphBlockOf: self createMicRootBlock.
	self assert: (paragraph isKindOf: MicParagraphBlock).

	self assert: paragraph textElements size equals: 1.
	self
		assert:
		(paragraph textElements collect: [ :each | each plainText ]) asArray
		equals: #( 'Pharo is cool...' ).
	paragraph textElements do: [ :each |
		self assert: each parent equals: paragraph ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testFirstParagraphBlockOfWithEllipsis [

	| paragraph |
	paragraph := micSingleSummarizer
		             maximumWords: 3;
		             firstParagraphBlockOf: self createMicRootBlock.
	self assert: (paragraph isKindOf: MicParagraphBlock).

	self assert: paragraph textElements size equals: 1.
	self
		assert:
		(paragraph textElements collect: [ :each | each plainText ]) asArray
		equals: #( 'Pharo is cool...' ).
	paragraph textElements do: [ :each |
		self assert: each parent equals: paragraph ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testFirstParagraphBlockOfWithNoParagraph [

	| paragraph |
	paragraph := micSingleSummarizer
		             maximumWords: 3;
		             firstParagraphBlockOf: (Microdown parse:
					              resources generateFilesystemExampleEmpty asFileReference
						              contents).
	self assert: (paragraph isKindOf: MicParagraphBlock).

	self assert: paragraph textElements size equals: 1.
	self
		assert:
		(paragraph textElements collect: [ :each | each plainText ]) asArray
		equals: #( 'Please add a paragraph' ).
	paragraph textElements do: [ :each |
		self assert: each parent equals: paragraph ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testFirstParagraphBlockOfWithoutEllipsis [

	| paragraph |
	paragraph := micSingleSummarizer
		             maximumWords: 5;
		             firstParagraphBlockOf:
			             (Microdown parse: 'Pharo is cool').
	self assert: (paragraph isKindOf: MicParagraphBlock).

	self assert: paragraph textElements size equals: 1.
	self
		assert:
		(paragraph textElements collect: [ :each | each plainText ]) asArray
		equals: #( 'Pharo is cool' ).
	paragraph textElements do: [ :each |
		self assert: each parent equals: paragraph ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testSummarize [

	| root |
	root := micSingleSummarizer summarize: self createMicRootBlock.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testSummarizeFile [

	| root |
	root := micSingleSummarizer summarizeFile:
		        resources generateFilesystemExample.
	self assert: (root isKindOf: MicRootBlock)
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithMetaDataAndWithDate [

	| root |
	root := micSingleSummarizer summarize: self createMicRootBlock.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3;
		assert: (root children first body at: #date)
		equals: '2019/01/08'
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithMetaDataAndWithoutDate [

	| root |
	root := micSingleSummarizer summarizeFile:
		        resources generateFilesystemExampleWithoutDateInMetadata.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3;
		assert: (root children first body at: #date)
		equals: micSingleSummarizer replacementDate
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithMetaDataButInvalidDate [

	| root |
	root := micSingleSummarizer summarizeFile:
		        resources generateFilesystemExampleWithBrokenDateInMetadata.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3;
		assert: (root children first atKey: #date)
		equals: micSingleSummarizer replacementDate
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithoutMetaData [

	| root |
	root := micSingleSummarizer summarizeFile:
		        resources generateFilesystemExampleWithoutMetadata.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3;
		assert: (root children first body at: #date)
		equals: micSingleSummarizer replacementDate
]
