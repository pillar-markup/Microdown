Class {
	#name : #MicResolvePathTest,
	#superclass : #TestCase,
	#instVars : [
		'resolver',
		'system',
		'parser'
	],
	#category : #'Microdown-ResolvePath-Tests'
}

{ #category : #running }
MicResolvePathTest >> setUp [
	super setUp.
	resolver := MicResolvePath new.
	system := FileSystem memory workingDirectory.
	parser := MicroDownParser new
]

{ #category : #tests }
MicResolvePathTest >> testResolveAbsolutePath [
| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](file:///folder/image.png)' ].
	mic := parser parseFile: file.
	self assert: mic children second children first isRelativeFilePath not.
	resolver visit: mic.
	self assert: mic children second children first isRelativeFilePath not.
	self assert: mic children second children first url asString equals: 'file:///folder/image.png'
	
]

{ #category : #tests }
MicResolvePathTest >> testResolveRelativePath [
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
