"
I check that `MicBookSitePublisher` publishes a small book, built in a memory file system, as a web site: one page per chapter of the index, written with the templates of the book, and a copy of its support files.
"
Class {
	#name : 'MicBookSitePublisherTest',
	#superclass : 'TestCase',
	#instVars : [
		'fileSystem',
		'book',
		'publisher'
	],
	#category : 'Microdown-Templated',
	#package : 'Microdown-Templated'
}

{ #category : 'running' }
MicBookSitePublisherTest >> setUp [

	super setUp.
	fileSystem := FileSystem memory.
	book := fileSystem / 'book'.
	self
		writeFile: 'index.md'
		contents: '<!inputFile|path=Chapters/One/one.md!>

<!inputFile|path=Chapters/Two/two.md!>';
		writeFile: 'Chapters/One/one.md' contents: '# First chapter';
		writeFile: 'Chapters/Two/two.md' contents: '# Second chapter';
		writeFile: '_support/templates/html/root.mustache'
		contents: '<body>{{{contents}}}</body>';
		writeFile: '_support/templates/html/header.mustache'
		contents:
			'<h{{level}} class="title"{{#id}} id="{{.}}"{{/id}}>{{{contents}}}</h{{level}}>';
		writeFile: '_support/html/css/book.css'
		contents: 'body { margin: 0 }'.
	publisher := MicBookSitePublisher new
		             bookDirectory: book;
		             yourself
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testChapterFilesFollowTheIndex [

	self
		assert:
		(publisher chapterFiles collect: [ :each | each basename ] as: Array)
		equals: #( 'one.md' 'two.md' )
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testDefaultOutputDirectory [

	self
		assert: publisher outputDirectory
		equals: book / '_result' / 'site'
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testPublishCopiesTheSupportFiles [

	publisher publish.

	self
		assert:
			(publisher outputDirectory / '_support' / 'html' / 'css'
			 / 'book.css') contents
		equals: 'body { margin: 0 }'
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testPublishTwiceReplacesThePages [

	publisher publish.
	self writeFile: 'Chapters/One/one.md' contents: '# Changed'.
	publisher publish.

	self
		assert: (publisher outputDirectory / 'one.html') contents
		equals: '<body><h1 class="title" id="changed">Changed</h1></body>'
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testPublishWritesOnePagePerChapter [

	publisher publish.

	self assert: (publisher outputDirectory / 'one.html') exists.
	self assert: (publisher outputDirectory / 'two.html') exists
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testPublishedPageLinksItsTableOfContentsToItsHeaders [

	self
		writeFile: '_support/templates/html/root.mustache'
		contents:
		'<title>{{title}}</title>{{#toc}}<nav>{{#children}}<a href="{{href}}">{{name}}</a>{{/children}}</nav>{{/toc}}{{{contents}}}'.

	publisher publish.

	self
		assert: (publisher outputDirectory / 'one.html') contents
		equals:
		'<title>First chapter</title><nav><a href="#first-chapter">First chapter</a></nav><h1 class="title" id="first-chapter">First chapter</h1>'
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testPublishedPageUsesTheBookTemplates [

	publisher publish.

	self
		assert: (publisher outputDirectory / 'one.html') contents
		equals:
		'<body><h1 class="title" id="first-chapter">First chapter</h1></body>'
]

{ #category : 'tests' }
MicBookSitePublisherTest >> testPublishedPageWithoutHeaderHasNoTableOfContents [

	self
		writeFile: '_support/templates/html/root.mustache'
		contents: '<title>{{title}}</title>{{#toc}}<nav></nav>{{/toc}}';
		writeFile: 'Chapters/One/one.md' contents: 'Just text'.

	publisher publish.

	self
		assert: (publisher outputDirectory / 'one.html') contents
		equals: '<title>one</title>'
]

{ #category : 'running' }
MicBookSitePublisherTest >> writeFile: aPath contents: aString [
	"Create the file at aPath in the book folder, with its parent folders."

	| file |
	file := book resolve: aPath.
	file parent ensureCreateDirectory.
	file writeStreamDo: [ :stream | stream nextPutAll: aString ]
]
