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
MicPathResolverTest >> testNotCallingResolver [
	"Using the parser only should not resolve the path, here we only call parse."
	
	| mic |
	mic := parser parse: '![caption](figures/blop/toto.png)'.
	self assert: (mic children first children first resources fullName endsWith: 'figures/blop/toto.png'). 
	
	mic := microdown parse: '![caption](/figures/blop/toto.png)'.
	self assert: mic children first children first class equals: MicFigureBlock.
	self assert: (mic children first children first resources fullName endsWith: '/figures/blop/toto.png').

	
]

{ #category : #tests }
MicPathResolverTest >> testParameterFileNotCallingResolver [
	"Using the parser should handle parameters"
	
	| mic |
	mic := parser parse: '![caption](figures/blop/toto.png?width=90&caption=''Super nice'')'.
	self assert: ('*figures/blop/toto.png*' match: mic children first children first resources fullName). 
	
	
	
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
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources url printString 
		equals: 'http://www.pharo.org/documentation/image.png'.
	
	self 
		assert: mic children second children first resources url printString 
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
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources url printString 
		equals: 'http://www.pharo.org/documentation/image.png'
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveAbsoluteResourcesAgainstRootFileSystem [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](/documentation/image.png)' ].

	mic := microdown 
		resolverRoot: system;
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources url fullName 
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
		resolvedTreeFrom: file contents.
		
	self assert: mic children second children first resources fullName equals: '/folder/figures/image.png'.
	self assert: mic children second children first resources isFile
	
]

{ #category : #tests }
MicPathResolverTest >> testResolveNotRelativePathWithInputfile [
	
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder' / 'file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=/chapters/withStyle.mic}?' ].

	mic := microdown 
				resolverRoot: system / '_result';
				resolvedTreeFrom: file contents.
	
	self assert: mic children first children first path fullName equals:  '/chapters/withStyle.mic'
	
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
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources fullName 
		equals: '/documentation/image.png'.
	
	self 
		assert: mic children second children first resources url  class 
		equals: FileReference.
	
	self 
		assert: mic children second children first resources url pathString 
		equals: '/documentation/image.png'.
		
	"Now we try with a working directory and we check that we get a resolved path."
	
	mic := microdown 
		resolverRoot: FileSystem workingDirectory ;
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources url class 
		equals: FileReference.
	self 
		assert: (mic children second children first resources url absolutePath asString splitOn: $/) size 
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
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources url printString 
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
		resolvedTreeFrom: file contents.

	self flag: #toFixLater.
	"We will see how to manage the url with subproject
	self 
		assert: mic children second children first resources url printString 
		equals: 'http://www.pharo.org/figures/documentation/image.png'
	"
	self 
		assert: mic children second children first resources url printString 
		equals: 'http://www.pharo.org/documentation/image.png'
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativePathWithInputfile [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '?{inputfile|path=chapters/withStyle.mic}?' ].
	
	mic := microdown 
				resolverRoot: system / '_result';
				resolvedTreeFrom: file contents.
				
	self 
		assert: mic children first children first path fullName equals: '/_result/chapters/withStyle.mic'

	
]

{ #category : #tests }
MicPathResolverTest >> testResolveRelativeResourcesAgainstRootFileSystem [
	| file mic |
	system := FileSystem memory workingDirectory.
	(system / 'folder') createDirectory.
	file := system / 'folder/file.mic'.
	file writeStreamDo: [ :stream | stream nextPutAll: '# section
![caption](documentation/image.png)' ].

	mic := microdown 
		resolverRoot: system / 'folder';
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources fullName
		equals: '/folder/documentation/image.png'.
	
		
	self 
		assert: mic children second children first resources url fullName
		equals: '/folder/documentation/image.png'
	

]

{ #category : #tests }
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
		resolvedTreeFrom: file contents.

	self 
		assert: mic children second children first resources fullName 
		equals: '/folder/subfil/documentation/image.png'
	
]
