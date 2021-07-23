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
	urlBefore := mic children second children first url asString.
	self assert: mic children second children first isRelativeFilePath not.
	
	resolver visit: mic.
	self assert: mic children second children first isRelativeFilePath not.
	self assert: mic children second children first url asString equals: urlBefore
	
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
	self assert: mic children second children first isRelativeFilePath.
	resolver visit: mic.
	self assert: mic children second children first isRelativeFilePath not
	
]
