Class {
	#name : #MicPharoPackageCommentResourceReference,
	#superclass : #MicPharoCommentResourceReference,
	#instVars : [
		'packageName'
	],
	#category : #'Microdown-Core'
}

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> contents [ 
	[ ^ packageName asPackage packageComment ]
	on: NotFound 
	do: [ MicResourceReferenceError signal: 'No package named ', packageName]
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> contents: aNewComment [ 
	[ ^ packageName asPackage packageComment: aNewComment]
	on: NotFound 
	do: [ MicResourceReferenceError signal: 'No package named ', packageName]
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> packageName [

	^ packageName
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> uri: aUri [

	"the uri is on the form commet://package/packageName - 
	packageName can be a prefix of a full package name"
	super uri: uri.
	packageName := aUri segments first
]
