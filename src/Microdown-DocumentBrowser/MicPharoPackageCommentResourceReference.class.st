"
My prime purpose it to allow access to the package comment.

My uri syntax is: `comment://package/categoryName`.

## loadMicrodown
My `loadMicrodown` returns the package comment of the package named categoryName or empty text if categoryName is not a package or if the package has no comment. Notice, `loadMicrodown` will return the synthesized comment (created by the class side method `buildMicroDownUsing:withComment:`)

When categoryName is a package, my two methods `contents` and `contents:` reads and writes the contents of the package comment.

## loadDirectory
My 'loadDirectory' has been designed to provide a deep directory. 

Most class category names are of the form 'aaa-bbb-ccc-ddd'. A call to `loadDirectory` with categoryName being 'aaa' will give children 'aaa-xxx','aaa-yyy','aaa-zzz'. A call with 'aaa-bbb' will return children 'aaa-bbb-xxx', 'aaa-bbb-yyy' etc.

### Tags in packages
If categoryName is an actual package name, the children will include 'aaa-bbb-xxx', 'aaa-bbb-yyy' packages as mentioned above. However, an additional child will be included for the package itself. Which in turn can return its classes or tags and then each tag can be expanded into classes.
"
Class {
	#name : #MicPharoPackageCommentResourceReference,
	#superclass : #MicPharoCommentResourceReference,
	#instVars : [
		'kind',
		'categoryName'
	],
	#category : #'Microdown-DocumentBrowser-ResourceModel'
}

{ #category : #testing }
MicPharoPackageCommentResourceReference >> canSave [
	"return true if I implement contents: "
	^self isPackage
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> categoryName [

	^ categoryName
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> childrenOfCategoryPrefix [

	"I am a prefix of a set of categories, 
	my children are those categories with one more depth in their name"

	| children |
	children := (categoryName 
		ifEmpty: [ SystemOrganizer default categories reject: [ :cat | cat beginsWith: 'BaselineOf' ] ]
		ifNotEmpty: [
			SystemOrganizer default categories
				select: [ :cat |  cat beginsWith: categoryName ]]) asSet.
	self isPackage 
		ifTrue: [ "remove the children which are actually tags"
			children := children \ ( categoryName asPackage classTags collect: [:tag | categoryName,'-',tag name]).].
	children := (children collect: [:cat | self reduceCategoryName: cat]) asSet asArray sort.
	^ children collect: [ :cat | |query|
		query := cat=categoryName ifTrue:['?kind=package'] ifFalse: [''].
		('comment://package/',cat,query) asMicResourceReference  ]
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> childrenOfPackageWithTag [
	"my categoryName is a package tag, children are the classes under that tag"
	^ (SystemOrganizer default classesInCategory:  categoryName)
			collect: [:cl | ('comment://class/',cl name) asMicResourceReference]
	 
]

{ #category : #initialization }
MicPharoPackageCommentResourceReference >> childrenOfRPackage [
	"I assume I am a RPackage, return my tags"
	|tags| 
	tags := (categoryName asPackage classTags) 
			reject: [:tag | #(Manifest Extensions) includes: tag name].
	tags := tags asArray sort: [ :a :b | a name < b name ].
	^ tags collect: [ :tag |
		('comment://package/', (categoryName, '-', tag name,'?kind=tag')) asMicResourceReference  ]
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> contents [ 
	[ ^ categoryName asPackage packageComment ]
	on: NotFound 
	do: [ ^ '' ]
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> contents: aNewComment [ 
	[ ^ categoryName asPackage packageComment: aNewComment]
	on: NotFound 
	do: [ MicResourceReferenceError signal: 'No package named ', categoryName]
]

{ #category : #testing }
MicPharoPackageCommentResourceReference >> isPackage [
	categoryName asPackageIfAbsent: [ ^ false ].
	^true
]

{ #category : #testing }
MicPharoPackageCommentResourceReference >> isTag [
	"return true if I am tag inside a package"
	| parent |
	parent := self parentPackage.
	"if no parent package exist, I am not a tag"
	parent ifNil: [ ^ false ].
	"If I am my own parent, I am not a tag"
	parent name = categoryName ifTrue: [ ^ false ].
	"I have a parent package, so I am a tag"
	^ true
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> kind [

	^ kind
]

{ #category : #'private - utilities' }
MicPharoPackageCommentResourceReference >> level [
	"return the number of '-' in categoryName"
	categoryName ifEmpty: [ ^-1 ].
	^ categoryName occurrencesOf: $-
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> loadChildren [
	kind = #prefix ifTrue: [ ^ self childrenOfCategoryPrefix  ].
	kind = #package ifTrue: [ ^ self childrenOfRPackage  ].
	kind = #tag ifTrue: [ ^ self childrenOfPackageWithTag  ].
	MicResourceReferenceError signal: 'Unknow kind in ', self uri printString.
]

{ #category : #loading }
MicPharoPackageCommentResourceReference >> loadMicrodown [
	"I override to provide the comment produced by beautifulComments"
	| builder |
	self isPackage ifFalse: [ ^ Microdown parse: '' ].
	builder := Microdown builder.
	self categoryName asPackage  
		buildMicroDownUsing: builder 
		withComment: self contents.
	^ builder contents
]

{ #category : #testing }
MicPharoPackageCommentResourceReference >> parentPackage [
	"return my parent package, or nil if none exist"
	| parts package |
	parts := categoryName splitOn: '-'.
	parts size to: 1 by: -1 do: [ :i | 
		package := ((parts truncateTo: i) joinUsing: '-') asPackageIfAbsent: [ nil ].
		package ifNotNil: [ ^ package ]
		 ].
	^ nil
]

{ #category : #'private - utilities' }
MicPharoPackageCommentResourceReference >> reduceCategoryName: aCategory [
	^ self reduceCategoryName: aCategory toLevel: self level + 1
]

{ #category : #'private - utilities' }
MicPharoPackageCommentResourceReference >> reduceCategoryName: aString toLevel: level [ 
	"a package name aaa-bbb-ccc-ddd reduced to level 0 is aaa, reduced to 2 is aaa-bbb-ccc"
	| parts |
	parts := aString splitOn: $-.
	^ (parts truncateTo: level+1) joinUsing: $-
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> setStrategy_old [
	"I am a rPackage | package-with-tag | packageName prefix | not a package at all"
	| noStarName |
	(categoryName asPackageIfAbsent: [ nil ])
		ifNotNil: [ ^ self childrenOfRPackage  ].
	(SystemOrganizer default classesInCategory:  categoryName)
		ifNotEmpty: [ ^ self childrenOfPackageWithTag ].
	noStarName := categoryName trimRight: [:c | c = $*].
	noStarName 
		ifEmpty: [ ^ self childrenOfCategoryPrefix ].
	(SystemOrganizer default categories 
			select: [ :cat | cat beginsWith: noStarName ])
		ifNotEmpty: [ ^ self childrenOfCategoryPrefix ].
	MicResourceReferenceError signal: 'Package ', categoryName, ' not found'
	
]

{ #category : #accessing }
MicPharoPackageCommentResourceReference >> uri: aUri [
	"the uri is on the form commet://package/packageName - 
	packageName can be a prefix of a full package name"
	super uri: aUri.
	categoryName := aUri segments
		ifNil: ['']
		ifNotNil: [ :segments | segments first ].
	kind := aUri query 
		ifNil: [ 'prefix' ]
		ifNotNil: [ :query | query at: #kind ifAbsent: [ 'prefix']].
	self isTag ifTrue: [ kind := #tag ]
]
