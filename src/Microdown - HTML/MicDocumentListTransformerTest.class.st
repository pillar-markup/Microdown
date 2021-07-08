Class {
	#name : #MicDocumentListTransformerTest,
	#superclass : #TestCase,
	#instVars : [
		'testingFileSystem'
	],
	#category : #'Microdown - HTML'
}

{ #category : #'as yet unclassified' }
MicDocumentListTransformerTest class >> directoryNameForTest [

	^ 'blogs'
]

{ #category : #private }
MicDocumentListTransformerTest class >> fileContentsOne [

	^ '## Okay

We gonna test annotations'
]

{ #category : #private }
MicDocumentListTransformerTest class >> fileContentsThree [

	^ '## And the third

one for testing annotations'
]

{ #category : #private }
MicDocumentListTransformerTest class >> fileContentsTwo [

	^ '## That''s the second

one for testing annotations'
]

{ #category : #private }
MicDocumentListTransformerTest class >> fileNameOne [

	^ 'blog1.mic'
]

{ #category : #private }
MicDocumentListTransformerTest class >> fileNameThree [

	^ 'blog3.mic'
]

{ #category : #private }
MicDocumentListTransformerTest class >> fileNameTwo [

	^ 'blog2.mic'
]

{ #category : #private }
MicDocumentListTransformerTest class >> templateFileContents [

	^ '<div>
  <p>{{{content}}}</p>
</div>'
]

{ #category : #private }
MicDocumentListTransformerTest >> actualClass [
	^ MicDocumentListTransformer
]

{ #category : #private }
MicDocumentListTransformerTest >> createFilesIn: aDirectory [

	(aDirectory / MicDocumentListTransformerTest fileNameOne)
		writeStreamDo: [ :stream |
			stream nextPutAll: MicDocumentListTransformerTest fileContentsOne ].
		
	(aDirectory / MicDocumentListTransformerTest fileNameTwo)
		writeStreamDo: [ :stream |
			stream nextPutAll: MicDocumentListTransformerTest fileContentsTwo ].
		
	(aDirectory / MicDocumentListTransformerTest fileNameThree)
		writeStreamDo: [ :stream |
			stream nextPutAll: MicDocumentListTransformerTest fileContentsThree ]
]

{ #category : #private }
MicDocumentListTransformerTest >> createTemplateFile [
	| dir templateFile |
	dir := (testingFileSystem / 'templates') ensureCreateDirectory.
	templateFile := (dir / 'docArticle.mustache') ensureCreateFile.
	templateFile writeStreamDo: [ :stream |
			stream nextPutAll: self class templateFileContents ].
]

{ #category : #private }
MicDocumentListTransformerTest >> setUp [
	
	| workingDirectory |
	super setUp.
	testingFileSystem := FileSystem memory workingDirectory.
	workingDirectory := (testingFileSystem / MicDocumentListTransformerTest directoryNameForTest) ensureCreateDirectory.
	self createFilesIn: workingDirectory.
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationCreateGoodLinks [
	| doc documentGroup sections |
	"${docList:path=blogs|limit=3|sort=name}$"
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'limit' put: '3';
					parameterAt: 'sort' put: 'name';
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	documentGroup := doc children second.
	
	sections := documentGroup children.

	self assert: sections size equals: 6.
	self assert: (sections at: 2) reference  equals: 'blogs/blog1.mic'.
	self assert: (sections at: 6) reference  equals: 'blogs/blog3.mic'.
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationIsReplacedByFilesContents [
	| doc documentGroup sections |
	"${docList:path=blogs|limit=3}$"
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'limit' put: '3';
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	documentGroup := doc children second.
	
	sections := documentGroup children.

	self assert: sections size equals: 6.
	
	self assert: sections first text equals: 'OkayWe gonna test annotations'.
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithEmptyMultipleMustacheTemplateShouldNotContainsRaw [
	| doc |
	"${docList:path=blogs}$"
	self createTemplateFile.
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	self deny: (doc children allSatisfy: [ :each | each class = MicRawBlock ])
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithLowLimitShouldOnlyTakeLimitNumberOfFilesInPath [
	| doc documentGroup links |
	"${docList:path=blogs|limit=2}$"
	doc := MicRootBlock new
		addChild: (MicTextBlock new substring: 'You');
		addChild:
			(MicDocumentList new
				parameterAt: 'path' put: 'blogs';
				parameterAt: 'limit' put: '2';
				yourself);
		yourself.


	(MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc.

	documentGroup := doc children second.

	links := documentGroup children select: [ :each | each class = PRInternalLink ].

	self deny: links size equals: 3.

	self assert: links size equals: 2
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithMultipleMustacheTemplateShouldContainsRaw [
	| doc |
	"${docList:path=blogs|sort=name|limit=3|templates=#('templates/docArticle.mustache' 'templates/me.mustache')}$"
	self createTemplateFile.
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'sort' put: 'name';
					parameterAt: 'limit' put: '3';
					parameterAt: 'templates' put: #('templates/docArticle.mustache' 'templates/me.mustache');
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	self assert: (doc children anySatisfy: [ :each | each class = MicRawBlock ])
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithTooHighLimitShouldOnlyTakeNumberOfFilesInPath [
	| doc documentGroup links |
	"${docList:path=blogs|limit=5}$"
	doc := MicRootBlock new
		addChild: (MicTextBlock new substring: 'You');
		addChild:
			(MicDocumentList new
				parameterAt: 'path' put: 'blogs';
				parameterAt: 'limit' put: '5';
				yourself);
		yourself.


	(MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc.

	documentGroup := doc children second.

	links := documentGroup children select: [ :each | each class = PRInternalLink ].

	self deny: links size equals: 5.

	"blogs is containing 3 files"
	self assert: links size equals: 3
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithWrongPathShouldReturnEmptyDocumentGroup [
	| doc documentGroup sections |
	"${docList:path=wrongDirectory|limit=3|sort=name}$"
	doc := MicRootBlock new
		addChild: (MicTextBlock new substring: 'You');
		addChild:
			(MicDocumentList new
				parameterAt: 'path' put: 'wrongDirectory';
				parameterAt: 'limit' put: '3';
				parameterAt: 'sort' put: 'name';
				yourself);
		yourself.


	(MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc.

	documentGroup := doc children second.

	sections := documentGroup children.
	self assertEmpty: sections
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithWrongTemplateExtensionShouldNotContainsRaw [
	| doc |
	"${docList:path=blogs|sort=name|limit=3|templates=#('templates/docArticle.avi')}$"
	self createTemplateFile.
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'sort' put: 'name';
					parameterAt: 'limit' put: '3';
					parameterAt: 'templates' put: #('templates/docArticle.avi');
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	self deny: (doc children allSatisfy: [ :each | each class = MicRawBlock ])
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithoutLimitParameterShouldTakeDefaultLimitValue [
	| doc documentGroup sections links |
	"${docList:path=blogs|sort=name}$"
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'sort' put: 'name';
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	documentGroup := doc children second.
	
	sections := documentGroup children.

	links := sections select: [ :each | each class = PRInternalLink ].

	self assert: sections size equals: 6.
	
	self assert: sections first text equals: 'OkayWe gonna test annotations'.

	"default value of limit 3"
	self assert: links size equals: 3
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithoutSortParameterShouldListFilesInArbitraryOrder [
	| doc documentGroup sections |
	"${docList:path=blogs|limit=2}$"
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'limit' put: '2';
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	documentGroup := doc children second.
	sections := documentGroup children.
	
	self assert: sections size equals: 4.
	self assert: sections first text equals: 'OkayWe gonna test annotations'.
]

{ #category : #private }
MicDocumentListTransformerTest >> testAnnotationWithoutSpecifyingPathShouldRaiseError [
	| doc |
	"${docList:sort=name|limit=5}$"
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'limit' put: '5';
					parameterAt: 'sort' put: 'name';
					yourself);
				yourself.
				
				
	self should: [((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc)] raise: Error
]

{ #category : #private }
MicDocumentListTransformerTest >> testFilesAreSortedByBaseName [
	| doc documentGroup sections |
	"${docList:path=blogs|sort=name|limit=3}$"
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'limit' put: '3';
					parameterAt: 'sort' put: 'name';
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	documentGroup := doc children second.
	
	sections := documentGroup children.

	self assert: sections size equals: 6.
	
	self assert: (sections at: 1) text equals: 'OkayWe gonna test annotations'.
	self assert: (sections at: 3) text equals: 'That''s the secondone for testing annotations'.
	self assert: (sections at: 5) text equals: 'And the thirdone for testing annotations'.
]

{ #category : #private }
MicDocumentListTransformerTest >> testFilesAreSortedByModificationDate [
	| doc documentGroup sections |
	"${docList:path=blogs|limit=3|sort=date}$"
	doc := MicRootBlock new 
				addChild: 
				(MicTextBlock new 
					substring: 'You');
				addChild:
				(MicDocumentList new 
					parameterAt: 'path' put: 'blogs';
					parameterAt: 'limit' put: '3';
					parameterAt: 'sort' put: 'date';
					yourself);
				yourself.
				
				
	((MicDocumentListTransformer withContext: (MicProject on: testingFileSystem)) start: doc).
	
	documentGroup := doc children second.
	
	sections := documentGroup children.

	self assert: sections size equals: 6.
	
	self assert: (sections at: 1) text equals: 'And the thirdone for testing annotations'.
	self assert: (sections at: 3) text equals: 'That''s the secondone for testing annotations'.
	self assert: (sections at: 5) text equals: 'OkayWe gonna test annotations'.
]
