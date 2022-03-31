"
I extend ZnUrl with a cache of file system hosts, to allow this uri syntax

`file://host/path`

You must register the host as `MicUri atHost: hostName put: aFilereference`

I am in particular suited to register memory filesystems, which can then be referenced from a uri. See test for examples
"
Class {
	#name : #MicUri,
	#superclass : #ZnUrl,
	#classVars : [
		'FileSystems'
	],
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #accessing }
MicUri class >> atHost: hostName put: filesystem [
	self fileSystems at: hostName asSymbol put: filesystem 
]

{ #category : #accessing }
MicUri class >> fileSystems [
	^ FileSystems ifNil: [ self resetFileSystems. FileSystems ]
]

{ #category : #accessing }
MicUri class >> fileSystems: dictionary [
	"I should be used only by testing"
	FileSystems := dictionary
]

{ #category : #accessing }
MicUri class >> filesystemAt: hostName [
	^ self fileSystems 
		at: hostName asSymbol 
		ifAbsent: [ nil ]
]

{ #category : #accessing }
MicUri class >> resetFileSystems [
	<script>
	FileSystems := Dictionary new.
	FileSystems 
		at: #workingdirectory put: FileSystem disk workingDirectory ;
		at: #localhost put: FileSystem disk root
]

{ #category : #converting }
MicUri >> asFileReference [
	"I override to allow access to the host file systems if used."
	| path fileSystem|
	self assert: self scheme = #file description: 'Only a file:// URL can be converted to a FileReference'.
	self host ifNil: [ ^ super asFileReference ].

	fileSystem := self class filesystemAt: self host.
	self assert: fileSystem notNil description: 'Host ', self host , ' is unknown'.
	
	self isSlash
		ifTrue: [ ^ fileSystem ].
	path := self isDirectoryPath
		ifTrue: [ segments allButLast ]
		ifFalse: [ segments copy ].
	^ FileReference fileSystem: fileSystem fileSystem path: (AbsolutePath withAll: path)
]
