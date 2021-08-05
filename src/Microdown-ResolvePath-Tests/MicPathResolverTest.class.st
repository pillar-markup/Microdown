Class {
	#name : #MicPathResolverTest,
	#superclass : #TestCase,
	#instVars : [
		'resolver',
		'system',
		'parser'
	],
	#category : #'Microdown-ResolvePath-Tests'
}

{ #category : #running }
MicPathResolverTest >> setUp [
	super setUp.
	resolver := MicPathResolver new.
	system := FileSystem memory workingDirectory.
	parser := MicroDownParser new
]

{ #category : #tests }
MicPathResolverTest >> testResolveNotRelativePath [
	
	| file mic urlBefore |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](file:///folder/image.png)' ].

	mic := parser parseFile: file.
	urlBefore := 'file:///folder/image.png'.
	self assert: mic children second children first isRelativeFilePath not.
	
	self assert: mic children second children first isRelativeFilePath not.
	self assert: mic children second children first url asString equals: urlBefore
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveNotRelativePathWithInputfile [
	
	| file mic urlBefore |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=/chapters/withStyle.mic}?' ].

	mic := parser parseFile: file.
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
	mic := parser parseFile: file.
	self assert: mic children first children first isRelativeFilePath not
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePathWithParse [
	| mic |
	mic := parser parse: '![caption](file://toto.png)'.
	self assert: mic children first children first isRelativeFilePath not
	
]
