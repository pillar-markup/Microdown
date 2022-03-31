"
I gather all the class and packet documentation in the system and present it.
If a packet name is AAA-BBB-CCC I make a hieararchy AAA->BBB->CCC to make it more structured.
I also group tags under package names.

"
Class {
	#name : #MicClassAndPacketDocProvider,
	#superclass : #MicAbstractDocProvider,
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #public }
MicClassAndPacketDocProvider >> addClassesIn: categories to: docCollection [
	| cat doc  |
	cat := categories 
		detect: [ :c | c = docCollection pathSegment ]
		ifNone: [ ^ self ].
	
	(SystemOrganizer default classesInCategory:  cat ) 
		do: [ :class | 
			doc := self buildDocumentForClass: class.
			(MicClassPackageSectionBlock fromRoot: doc header: class name)
					classOfDoc: class;
					propertyAt: #source put: class comment;
					parent: docCollection].
]

{ #category : #adding }
MicClassAndPacketDocProvider >> addManifestDocIn: categories to: docCollection [
	| manifest doc |
	manifest := categories 
		detect: [ :cat | cat = (docCollection pathSegment , '-Manifest')  ]
		ifNone: [ ^ self ].
	(SystemOrganizer default classesInCategory:  manifest ) 
		do: [ :class | 
			doc := self buildDocumentForClass: class.
			(MicClassPackageSectionBlock fromRoot: doc header: 'PACKAGE ',(manifest copyUpToLast: $- ))
					classOfDoc: class;
					propertyAt: #source put: class comment;
					parent: docCollection].
]

{ #category : #adding }
MicClassAndPacketDocProvider >> addSubsectionsIn: categories to: docCollection [
	|level subCategories|
	level := (docCollection pathSegment occurrencesOf: $-) + 1.
	subCategories := categories 
		select: [ :cat | (cat occurrencesOf: $-) >= level ]
		thenCollect: [ :cat | self reduceCategoryName: cat toLevel: level].
	subCategories := subCategories reject: [ :cat | cat endsWith: '-Manifest' ].
	subCategories := subCategories asSet asArray sort.
	subCategories do: [ :cat |
		MicClassPackageDocumentCollection new
			title: cat;
			pathSegment: cat;
			parent: docCollection].
]

{ #category : #rendering }
MicClassAndPacketDocProvider >> buildDocumentForClass: aClass [ 
	| builder source|
	builder := Microdown builder.
	aClass instanceSide buildMicroDownUsing: builder withComment: aClass comment.
	source := builder contents.
	^ Microdown parse: source.
]

{ #category : #testing }
MicClassAndPacketDocProvider >> canSave [
	^ true
]

{ #category : #public }
MicClassAndPacketDocProvider >> loadDocuments [
	"I return the toplevel projects of pharo. I produce a lazy document collection"
	| all projects nonBaselines topLevelNames rootCollection |
	all := 	SystemOrganizer default categories.
	nonBaselines := all reject: [ :cat | cat beginsWith: 'BaselineOf' ].
	topLevelNames := (nonBaselines collect: [ :cat | cat copyUpTo: $- ]).
	topLevelNames := topLevelNames asSet asArray sort.
	rootCollection := MicDocumentCollection new
		title: 'Class comments';
		parent: self.
	projects := topLevelNames collect: [ :name |
		MicClassPackageDocumentCollection new
			title: name;
			pathSegment: name;
			parent: rootCollection ].
	^rootCollection 
]

{ #category : #private }
MicClassAndPacketDocProvider >> reduceCategoryName: aString toLevel: level [ 
	"a package name aaa-bbb-ccc-ddd reduced to level 0 is aaa, reduced to 2 is aaa-bbb-ccc"
	| parts |
	parts := aString splitOn: $-.
	^ (parts truncateTo: level+1) joinUsing: $-
]

{ #category : #rendering }
MicClassAndPacketDocProvider >> renderSection: aSection [
	| doc |
	doc := self buildDocumentForClass: aSection classOfDoc.
	^ Microdown asRichText: doc 
]

{ #category : #private }
MicClassAndPacketDocProvider >> rootDocument [
	^ MicDocumentCollection new
		title: 'Pharo projects'
		
]

{ #category : #testing }
MicClassAndPacketDocProvider >> saveSection: docToSave [
	docToSave classOfDoc comment: (docToSave propertyAt: #source)
]

{ #category : #public }
MicClassAndPacketDocProvider >> setChildrenOf: docCollection [
	"return a collection of packages named aString-XXX, and classes in package aString (no -XXX)"
	| subCategories|
	subCategories := SystemOrganizer default categories
		select: [ :cat | cat beginsWith: docCollection pathSegment ].
	self addManifestDocIn: subCategories to: docCollection.
	self addSubsectionsIn: subCategories to: docCollection. 
	self addClassesIn: subCategories to: docCollection.
	^docCollection  
	
]
