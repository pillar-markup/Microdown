Class {
	#name : 'MicSingleSummarizerTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Blog-Tests',
	#package : 'Microdown-Blog-Tests'
}

{ #category : 'enumerating' }
MicSingleSummarizerTest >> createMicRootBlock [

	^ Microdown parse: self generateFilesystemExample asFileReference contents
]

{ #category : 'enumerating' }
MicSingleSummarizerTest >> generateFilesystemExample [

	| file |
	file := FileSystem memory workingDirectory / 'anExample1.md'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# A Cool Story
@sec1

Pharo is cool but _this is_ a superlong _paragraph_ Simple powerful language: No constructors, no types declaration, no interfaces, no primitive types. Yet a powerful and elegant language with a full syntax fitting in one postcard! Pharo is objects and messages all the way down. _Live_, immersive environment: Immediate feedback at any moment of your development: _Developing_, testing, debugging. Even in production environments, you will never be stuck in compiling and deploying steps again!
    

Amazing debugging experience: The Pharo environment includes a debugger unlike anything you''ve seen before. It allows you to step through code, restart the execution of methods, create methods on the fly, and much more!

Pharo is yours: Pharo is made by an incredible community, with more than 100 contributors for the last revision of the platform and hundreds of people contributing constantly with frameworks and libraries. Fully open-source: Pharo full stack is released under MIT License and available on GitHub


```
this is a code blu blu
```
' ].

	^ file.
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
MicSingleSummarizerTest >> testFirstParagraphBlockOf [

	| paragraph |
	
	paragraph := MicSingleSummarizer new
		maximumWords: 3;
		firstParagraphBlockOf: self createMicRootBlock.
	self assert: ( paragraph isKindOf: MicParagraphBlock ).
	
	self assert: paragraph textElements size equals: 3.
	self assert: (paragraph textElements collect: [:each | each plainText ]) asArray equals: #('Pharo is cool but ' 'this is' ' a superlong ').
	paragraph textElements do: [ :each | self assert: each parent equals: paragraph ]
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testSummarize [

	| root |
	root := MicSingleSummarizer new summarize: self createMicRootBlock.
	self assert: (root isKindOf: MicRootBlock);
	assert: (root children size) equals: 3.
]

{ #category : 'tests' }
MicSingleSummarizerTest >> testSummarizeFile [

	| root |
	root := MicSingleSummarizer new summarizeFile: self generateFilesystemExample.
	self assert: (root isKindOf: MicRootBlock)
	
	
]
