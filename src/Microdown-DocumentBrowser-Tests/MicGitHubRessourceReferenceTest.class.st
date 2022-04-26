"
A MicGitHubRessourceReferenceTest is a test class for testing the behavior of MicGitHubRessourceReference
"
Class {
	#name : #MicGitHubRessourceReferenceTest,
	#superclass : #TestCase,
	#category : #'Microdown-DocumentBrowser-Tests-ResourceModel'
}

{ #category : #'api - accessing' }
MicGitHubRessourceReferenceTest >> ensureApi: anInteger for: aFullBlockClosure [ 
	MicGitHubAPI apiCallsRemaining >= anInteger 
		ifTrue: [ aFullBlockClosure value ]
		ifFalse: [ self skip: 'Rate limit exhaused' ]
]

{ #category : #'test data' }
MicGitHubRessourceReferenceTest >> sampleTreeResponse [

	^ { 
		  ('sha' -> '3d2ff94661d6a0399e3f4ea0ea5dc36a45971bf2').
		  ('tree' -> { 
			   { 
				   ('mode' -> '040000').
				   ('path' -> 'images').
				   ('sha' -> 'b1dc21dabca4c774fec51c52b8b5f576cf53ff08').
				   ('type' -> 'tree'). 
				   ('url'
				    ->
				    'https://api.github.com/repos/pillar-markup/Microdown/git/trees/b1dc21dabca4c774fec51c52b8b5f576cf53ff08') }
				   asDictionary.
			   { 
				   ('mode' -> '100644').
				   ('path' -> 'other.md').
				   ('sha' -> '1b37a7800cfdfd2692662bfd6e743b5a33faef46').
				   ('size' -> 97).
				   ('type' -> 'blob').
				   ('url'
				    ->
				    'https://api.github.com/repos/pillar-markup/Microdown/git/blobs/1b37a7800cfdfd2692662bfd6e743b5a33faef46') }
				   asDictionary.
			   { 
				   ('mode' -> '100644').
				   ('path' -> 'readme.md').
				   ('sha' -> '0d0a4c4fbe085e75d0cc3b69b5f520b9c4b4c288').
				   ('size' -> 439).
				   ('type' -> 'blob').
				   ('url'
				    ->
				    'https://api.github.com/repos/pillar-markup/Microdown/git/blobs/0d0a4c4fbe085e75d0cc3b69b5f520b9c4b4c288') }
				   asDictionary.
			   { 
				   ('mode' -> '040000').
				   ('path' -> 'subfolder').
				   ('sha' -> 'b490118847905baf156093fba34ce8381304f252').
				   ('type' -> 'tree').
				   ('url'
				    ->
				    'https://api.github.com/repos/pillar-markup/Microdown/git/trees/b490118847905baf156093fba34ce8381304f252') }
				   asDictionary.
			   { 
				   ('mode' -> '100644').
				   ('path' -> 'toplevel.png').
				   ('sha' -> 'e301bdce18877ad507b6080d4122eda9fc05461a').
				   ('size' -> 442).
				   ('type' -> 'blob').
				   ('url'
				    ->
				    'https://api.github.com/repos/pillar-markup/Microdown/git/blobs/e301bdce18877ad507b6080d4122eda9fc05461a') }
				   asDictionary }).
		  ('truncated' -> false).
		  ('url'
		   ->
		   'https://api.github.com/repos/pillar-markup/Microdown/git/trees/3d2ff94661d6a0399e3f4ea0ea5dc36a45971bf2') }
		  asDictionary
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testContents [
	|uri ref contents|
	self ensureApi: 1 for: [
		uri := 'github://pillar-markup/Microdown/doc/testMicrodown/readme.md'.
		ref := MicResourceReference fromUri: uri.
		contents := ref contents.
		self 
			assert: (contents beginsWith: '# Test documents' )]
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testExtractFolderReferencesFrom [

	| uri ref response folders expectedRaw |
	self ensureApi: 1 for: [
		uri := 'github://pillar-markup/Microdown:testBranch/doc/testMicrodown'.
		ref := MicResourceReference fromUri: uri.
		response := self sampleTreeResponse.
		folders := ref extractFolderReferencesFrom: response.
		self assert: folders size equals: 2.
		expectedRaw := 'https://raw.githubusercontent.com/pillar-markup/Microdown/testBranch/doc/testMicrodown'.
		self assert: (folders 
			allSatisfy: [:folder |
				folder pathStringForRawAccess beginsWith: expectedRaw]) ]
	
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testExtractMicrodownDocReferencesFrom [

	| uri ref response documents expectedRaw |
	self ensureApi: 1 for: [ 
		uri := 'github://pillar-markup/Microdown:testBranch/doc/testMicrodown'.
		ref := MicResourceReference fromUri: uri.
		response := self sampleTreeResponse.
		documents := ref extractMicrodownDocReferencesFrom: response.
		self assert: documents size equals: 2.
		expectedRaw := 'https://raw.githubusercontent.com/pillar-markup/Microdown/testBranch/doc/testMicrodown'.
		self assert: (documents 
			allSatisfy: [:doc |
				doc uri printString beginsWith: expectedRaw]) ]
	
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testGithubTreesApiRequest [
	|uri ref|
	uri := 'github://JohnDoe/Calculator:devBranch/path/to/docs'.
	ref := MicResourceReference fromUri: uri.
	self 
		assert: ref githubTreesApiRequest  
		equals: 'https://api.github.com/repos/johndoe/Calculator/git/trees/devBranch'.
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testLoadChildren [
	|uri ref children|
	self ensureApi: 3 for: [
		uri := 'github://pillar-markup/Microdown/doc/testMicrodown'.
		ref := MicResourceReference fromUri: uri.
		children := ref loadChildren.
		self 
			assert: children size 
			equals: 4.
		self assert: (children allSatisfy: [:child | child isKindOf: MicAbsoluteResourceReference ])]
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testUri [
	|uri ref|
	uri := 'github://JohnDoe/Calculator:devBranch/path/to/docs'.
	ref := MicResourceReference fromUri: uri.
	self assert: ref class equals: MicGitHubRessourceReference.
	self assert: ref user equals: 'johndoe'.
	self assert: ref project equals: 'Calculator'.
	self assert: ref branch equals: 'devBranch'.
	self assert: ref docFolder equals: { 'path'. 'to'. 'docs' }
]

{ #category : #tests }
MicGitHubRessourceReferenceTest >> testUri_defaultBranch_Pharo_withDoc [
	|uri ref|
	uri := 'github://pharo-project/pharo:dummyBranch/path/to/docs'.
	ref := MicResourceReference fromUri: uri.
	self assert: ref docFolder equals: { 'path'. 'to'. 'docs' }
]
