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

{ #category : #tests }
MicPathResolverTest >> testResolveAbsoluteFileWithURL [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](/documentation/image.png)' ].

	mic := microdown 
		resolverRoot: 'http://www.pharo.org' asUrl;
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference printString 
		equals: 'http://www.pharo.org/documentation/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveAbsoluteFileWithURL2 [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](/documentation/image.png)' ].

	mic := microdown 
		resolverRoot: 'http://www.pharo.org/figures/' asUrl;
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference printString 
		equals: 'http://www.pharo.org/figures//documentation/image.png'.
		
	self flag: #unsupported. 
	"I was expecting to get 'http://www.pharo.org/documentation/image.png'. sso may be I will have to 
	implement it."
	
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
		equals: '/documentation/image.png'
	
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
		
	self assert: mic children second children first resources urlOrReference fullName equals: '/folder/figures/image.png'.
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

{ #category : #'verified tests' }
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
		assert: mic children second children first resources urlOrReference pathString 
		equals: '/documentation/image.png'.
		
	"Now we try with a working directory and we check that we get a resolved path."
	
	mic := microdown 
		resolverRoot: FileSystem workingDirectory ;
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference class 
		equals: FileReference.
	self 
		assert: (mic children second children first resources urlOrReference absolutePath asString splitOn: $/) size 
			>  #('documentation' 'image.png') size.
			
	
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
		assert: mic children second children first resources urlOrReference printString 
		equals: 'http://www.pharo.org/documentation/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativeFileWithURL2 [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](documentation/image.png)' ].

	mic := microdown 
		resolverRoot: 'http://www.pharo.org/figures' asUrl;
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference printString 
		equals: 'http://www.pharo.org/figures/documentation/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePathWithInputfile [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=chapters/withStyle.mic}?' ].
	
	mic := microdown 
				resolverRoot: system;
				treeFromFile: file.
	
	
	self 
		assert: mic children first children first path urlOrReference fullName 
		equals: '//chapters/withStyle.mic'

	
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
		resolverRoot: system / 'folder';
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference asString
		equals: 'memory:///folder/documentation/image.png'.
	
	"My problem is that 'memory:///documentation/image.png' does not tell me that we correctly resolve the path :(
	
	"	
		
	self 
		assert: mic children second children first resources urlOrReference fullName
		equals: '/folder/documentation/image.png'
	

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
		resolverRoot: system / 'folder' / 'subfil' ;
		treeFromFile: file.

	self 
		assert: mic children second children first resources urlOrReference fullName 
		equals: '/folder/subfil/documentation/image.png'
	
]
