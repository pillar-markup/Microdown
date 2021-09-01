Class {
	#name : #MicPathResolverTest,
	#superclass : #TestCase,
	#instVars : [
		'resolver',
		'system',
		'parser',
		'microdown'
	],
	#category : #'Microdown-Tests-Resources'
}

{ #category : #running }
MicPathResolverTest >> setUp [
	super setUp.
	resolver := MicPathResolver new.
	system := FileSystem memory workingDirectory.
	parser := MicroDownParser new.
	microdown := Microdown new
]

{ #category : #tests }
MicPathResolverTest >> testResolveNotRelativePath [
	
	| file mic urlBefore |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](folder/image.png)' ].

	mic := microdown treeFromFile: file.
	urlBefore := 'folder/image.png'.
	self assert: mic children second children first url printString equals: '/folder/image.png'.
	
	self assert: mic children second children first url asString equals: urlBefore
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveNotRelativePathWithInputfile [
	
	| file mic urlBefore |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=/chapters/withStyle.mic}?' ].

	mic := microdown treeFromFile: file.
	urlBefore := '/chapters/withStyle.mic'.
	self assert: mic children first children first isRelativeFilePath not.
	self assert: mic children first children first path equals: urlBefore
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePath [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](file:///figures/image.png)' ].

	mic := microdown 
		resolverRoot: system  / 'folder';
		treeFromFile: file.
	
	self assert: mic children second children first url isAbsolute.
	self assert: mic children second children first url asString equals: 'file:///folder/figures/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePathOld [
| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](file://figures/image.png)' ].
	mic := parser parseFile: file.
	self assert: mic children second children first isRelativeFilePath not.
	self assert: mic children second children first url asString equals: 'file:///folder/figures/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePathWithInputfile [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=chapters/withStyle.mic}?' ].
	mic := microdown treeFromFile: file.
	self assert: mic children first children first isRelativeFilePath not
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePathWithParse [
	"Using the parser only should not resolve the path."
	
	| mic |
	mic := parser parse: '![caption](file://toto.png)'.
	self assert: mic children first children first url isAbsolute.
	
	mic := microdown parse: '![caption](file://toto.png)'.
	self assert: mic children first children first url isAbsolute
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativeURL [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](documentation/image.png)' ].

	mic := microdown 
		resolverRoot: 'http://www.pharo.org' asUrl;
		treeFromFile: file.

	self 
		assert: mic children second children first url asString 
		equals: 'http://www.pharo.org/documentation/image.png'
	
]
