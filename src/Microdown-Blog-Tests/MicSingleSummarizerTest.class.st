Class {
	#name : 'MicSingleSummarizerTest',
	#superclass : 'TestCase',
	#instVars : [
		'micSingleSummarizer'
	],
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'enumerating' }
MicSingleSummarizerTest >> createMicRootBlock [

	| micRootBlock |

	micRootBlock := Microdown parse: self generateFilesystemExample contents.
	^ micRootBlock fromFile: self generateFilesystemExample.
]

{ #category : 'enumerating' }
MicSingleSummarizerTest >> generateFilesystemExample [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "date" : "8 January 2019"
}
# A Cool Story
@sec1

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!

Pharo is yours: Pharo is made by an incredible community, with more than 100 contributors for the last revision of the platform and hundreds of people contributing constantly with frameworks and libraries. Fully open-source: Pharo full stack is released under MIT License and available on GitHub


```
this is a code blu blu
```
' ].

	^ file asFileReference 
]

{ #category : 'enumerating' }
MicSingleSummarizerTest >> generateFilesystemExampleEmpty [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '' ].

	^ file asFileReference
]

{ #category : 'enumerating' }
MicSingleSummarizerTest >> generateFilesystemExampleWithoutDateInMetadata [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '{
    "title" : "Cool"
}
# A Cool Story
@sec1

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!

Pharo is yours: Pharo is made by an incredible community, with more than 100 contributors for the last revision of the platform and hundreds of people contributing constantly with frameworks and libraries. Fully open-source: Pharo full stack is released under MIT License and available on GitHub


```
this is a code blu blu
```
' ].

	^ file asFileReference
]

{ #category : 'enumerating' }
MicSingleSummarizerTest >> generateFilesystemExampleWithoutMetadata [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream |
		stream nextPutAll: '# A Cool Story
@sec1

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!

Pharo is yours: Pharo is made by an incredible community, with more than 100 contributors for the last revision of the platform and hundreds of people contributing constantly with frameworks and libraries. Fully open-source: Pharo full stack is released under MIT License and available on GitHub


```
this is a code blu blu
```
' ].

	^ file asFileReference
]

{ #category : 'running' }
MicSingleSummarizerTest >> setUp [

	super setUp.

	"Put here a common initialization logic for tests"
	micSingleSummarizer := MicSingleSummarizer new.
	micSingleSummarizer targetDirectory: '/html/' asFileReference
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testContents [

	| root dumper |
	root := MicRealDumper new visit:
		        (micSingleSummarizer summarize: self createMicRootBlock).
	dumper := Microdown parse:
		          '# [A Cool Story](' , '' , '/anExample1.html' , '' , ')
	Pharo is cool but this is a superlong paragraph Simple powerful language: No constructors, no ...'.

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
	header := micSingleSummarizer firstHeaderBlockOf:
		          (Microdown parse:
			           self generateFilesystemExampleEmpty asFileReference
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
		equals: #( 'Pharo is cool ...' ).
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
		equals: #( 'Pharo is cool ...' ).
	paragraph textElements do: [ :each |
		self assert: each parent equals: paragraph ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testFirstParagraphBlockOfWithNoParagraph [

	| paragraph |
	paragraph := micSingleSummarizer
		             maximumWords: 3;
		             firstParagraphBlockOf: (Microdown parse:
					              self generateFilesystemExampleEmpty asFileReference
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
		        self generateFilesystemExample.
	self assert: (root isKindOf: MicRootBlock)
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithMetaDataAndWithDate [

	| root |
	root := micSingleSummarizer summarize: self createMicRootBlock.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3;
		assert: ((root children at:1) body at: #date ) equals: '8 January 2019'.
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithMetaDataAndWithoutDate [

	| root |
	
	root := micSingleSummarizer summarizeFile:
		        self generateFilesystemExampleWithoutDateInMetadata.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3;
		assert: ((root children at: 1) body at: #date)
		equals: '25 December 1970'
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testWithoutMetaData [

	| root |
	root := micSingleSummarizer summarizeFile:
			         self generateFilesystemExampleWithoutMetadata.
	self
		assert: (root isKindOf: MicRootBlock);
		assert: root children size equals: 3;
		assert: ((root children at: 1) body at: #date)
		equals: '25 December 1970'
]
