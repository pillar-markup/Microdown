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

{ #category : #'verified tests' }
MicPathResolverTest >> testNotCallingResolver [
	"Using the parser only should not resolve the path, here we only call parse."
	
	| mic |
	mic := parser parse: '![caption](figures/blop/toto.png)'.
	self assert: mic children first children first resources isRelative.
	
	mic := microdown parse: '![caption](/figures/blop/toto.png)'.
	self assert: mic children first children first class equals: MicFigureBlock.
	self assert: mic children first children first resources isAbsolute.
	self assert: mic children first children first resources printString equals: '/figures/blop/toto.png'.

	
]

{ #category : #'file reference tests' }
MicPathResolverTest >> testResolveAbsoluteResourcesAgainstRootFileSystem [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](/documentation/image.png)' ].

	mic := microdown 
		resolverRoot: system;
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference fullName 
		equals: 'memory:///documentation/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveNotRelativePath [
	
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](/folder/figures/image.png)' ].

	mic := microdown 
		resolverRoot: system; 
		treeFromFile: file.
		
	self assert: mic children second children first resources asString equals: '/folder/figures/image.png'.
	self assert: mic children second children first resources isFile
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveNotRelativePathWithInputfile [
	
	| file mic urlBefore |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=/chapters/withStyle.mic}?' ].
	self halt.
	mic := microdown treeFromFile: file.
	urlBefore := '/chapters/withStyle.mic'.
	self assert: mic children first children first isRelativeFilePath not.
	self assert: mic children first children first path equals: urlBefore
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativeFileWithFileSystem [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](documentation/image.png)' ].

	mic := microdown 
		resolverRoot: system;
		treeFromFile: file.

	self 
		assert: mic children second children first resources asString 
		equals: 'documentation/image.png'.
	"does not prove anything since printString is cheating and returning the string and not using the underlying object."
	
	self 
		assert: mic children second children first resources urlOrReference class 
		equals: FileReference.
	self 
		assert: mic children second children first resources urlOrReference fullName 
		equals: 'documentation/image.png'.
	
	
	
	mic := microdown 
		resolverRoot: FileSystem workingDirectory ;
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference class equals: FileReference.
	self 
		assert: mic children second children first resources urlOrReference path  equals: Path * 'documentation' / 'image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativeFileWithURL [
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

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePathWithInputfile [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=chapters/withStyle.mic}?' ].
	mic := microdown treeFromFile: file.
	self assert: mic children first children first isRelativeFilePath not.
	self assert: mic children first children first resources printString
	
]

{ #category : #'file reference tests' }
MicPathResolverTest >> testResolveRelativeResourcesAgainstRootFileSystem [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](documentation/image.png)' ].

	mic := microdown 
		resolverRoot: system;
		treeFromFile: file.

	self 
		assert: mic children second children first resources asString 
		equals: 'memory:///documentation/image.png'
	
]

{ #category : #'file reference tests' }
MicPathResolverTest >> testResolveRelativeResourcesAgainstSubFolders [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](documentation/image.png)' ].

	"now we resolved against folder and not the root of the filesystem"
	mic := microdown 
		resolverRoot: system / 'folder' ;
		treeFromFile: file.

	self 
		assert: mic children second children first resources asString 
		equals: 'memory:///folder/documentation/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativeURL2 [
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
		assert: mic children second children first resources asString 
		equals: 'http://www.pharo.org/documentation/image.png'
	
]
