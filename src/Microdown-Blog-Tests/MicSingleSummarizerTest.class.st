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
		                resources generateFilesystemExample1 contents.
	^ micRootBlock fromFile: resources generateFilesystemExample1
]

{ #category : 'running' }
MicSingleSummarizerTest >> setUp [

	super setUp.
	resources := MicFileTestResources new.
	micSingleSummarizer := MicSingleSummarizer new.
	micSingleSummarizer targetDirectory: '/html/' asFileReference;
	root: resources genericEmptyRootPath.
	
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testContents [

	| root dumper |
	root := MicRealDumper new visit:
		        (micSingleSummarizer summarize: self createMicRootBlock).

	dumper := MicRealDumper new visit: MicFileTestResources new dumperInput1.

	self assert: root contents equals: dumper contents
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testContentsWithRootPath [

	| root dumper |
	
	micSingleSummarizer root: resources genericNonEmptyRootPath.
	root := MicRealDumper new visit:
		        (micSingleSummarizer summarize: self createMicRootBlock).

	dumper := MicRealDumper new visit: MicFileTestResources new dumperInput1WithRootPath.

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
MicSingleSummarizerTest >> testHeaderLinkWithRootPath [

	| header linkBlock |

	micSingleSummarizer root: resources genericNonEmptyRootPath.
	header := micSingleSummarizer headerLink: self createMicRootBlock.
	
	self assert: (header isKindOf: MicHeaderBlock).
	linkBlock := header children first.
	self assert: (linkBlock isKindOf: MicLinkBlock);
	assert: linkBlock plainText equals: '[A Cool Story](', resources genericNonEmptyRootPath ,'/anExample1.html)'
	
	
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testSummarize [

	| root |
	root := micSingleSummarizer summarize: self createMicRootBlock.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 4;
		assert: (root children first isKindOf: MicMetaDataBlock);
		assert: (root children second isKindOf: MicHeaderBlock);
		assert: (root children third isKindOf: MicParagraphBlock);
		assert: (root children fourth isKindOf: MicParagraphBlock).
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testSummarizeFile [

	| root |
	root := micSingleSummarizer summarizeFile:
		        resources generateFilesystemExample1.
	self assert: (root isKindOf: MicRootBlock)
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithFromFile [

	| root fromFile |
	root := self createMicRootBlock.
	fromFile := root fromFile.

	micSingleSummarizer verifyFromFile: root.

	self assert: root fromFile equals: fromFile
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithFromFileNil [

	| root |
	root := self createMicRootBlock.
	root fromFile: nil.

	micSingleSummarizer verifyFromFile: root.

	self assert: root fromFile equals: ''
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithMetaDataAndWithDate [

	| root |
	root := micSingleSummarizer summarize: self createMicRootBlock.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 4;
		assert: (root children first body at: #date) equals: '2019/01/09'
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithMetaDataAndWithoutDate [

	| root |
	root := micSingleSummarizer summarizeFile:
		        resources generateFilesystemExampleWithoutDateInMetadata.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 4;
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
		assert: root children size equals: 4;
		assert: (root children first atKey: #date)
		equals: micSingleSummarizer replacementDate
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithoutFromFile [

	| root |
	root := Microdown parse:
		        resources generateFilesystemExample1 contents.

	micSingleSummarizer verifyFromFile: root.

	self assert: root fromFile equals: ''
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithoutMetaData [

	| root |
	root := micSingleSummarizer summarizeFile:
		        resources generateFilesystemExampleWithoutMetadata.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 4;
		assert: (root children first body at: #date)
		equals: micSingleSummarizer replacementDate
]
