"
As there are many CSS frameworks available each with its own set of features, this class implements a helper for clients to obtain, configure, and query `MicCSSFramework`s. 

Frameworks differ each other in multiple aspects:

  - Contain opinionated styles.
  - Lower or higher-level, intended to be customized or not.
  - Theme provisioning (for example, light & dark modes).
  - It may contain fully responsive layout, which optimizes content to different types of screens.
  - Is provided through a CDN (Content Delivery Network), which are a set of web servers that can deliver commonly-requested content very quickly all over the world, enabling browser caching and dynamic patching.

# Usage

## Obtain CSS frameworks

To download a set of pre-defined CSS frameworks, evaluate:

```language=Pharo
MicCSSProvider downloadCSSFrameworks.
```

Currently all downloaded frameworks are class-less CSS.

The destination folder where CSS frameworks are downloaded can be configured with #destinationDir:

```language=Pharo
MicCSSProvider 
	destinationDir: 'css_libs';
	downloadCSSFrameworks
```

If not specified, a default destination folder is set automatically.

## Querying CSS libraries

To inspect the currently available libraries:

```language=Pharo
MicCSSProvider frameworks.
```

To filter CSS Frameworks delivered through a CDN:

```language=Pharo
MicCSSProvider frameworks select: #hasCDN.
```

## Adding a CSS Framework

To add a new framework, see the class method #frameworks. At least one of the two following keys must exist: #minCss or #css.

### Mandatory Attributes

- #minCss : associate to the minified version of the CSS file.
- #css : associate to the non-obfuscated, non-minified CSS file.
- #repository : associates with a URL string to access the CSS library main repository.

### Optional Attributes

- #fluidCss : associate to the Fluid CSS resource (a CSS for responsive UIs).
- #normalizeCss : associate to the Normalize.CSS library



"
Class {
	#name : #MicCSSProvider,
	#superclass : #Object,
	#instVars : [
		'cssFile',
		'destinationDir',
		'cssBasePath',
		'cssDownloader'
	],
	#classVars : [
		'Frameworks'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSProvider class >> defaultFramework [
	"Answer a <String> with the name of the CSS library used as default"

	^ 'AwsmCSS'
]

{ #category : #frameworks }
MicCSSProvider class >> defaultFrameworks [
	"Answer a <Collection> of available <MicCSSFramework> taken from the receiver's specifications"

	^ self frameworksSpecs collect: [ : frwSpec |
		MicCSSFramework new
			name: (frwSpec at: #name);
			mainUrl: (frwSpec at: #repository);
			cssUrl: (frwSpec at: #css ifAbsent: [ String empty ]);
			minCssUrl: (frwSpec at: #minCss ifAbsent: [ String empty ]);
			normalizeUrl: (frwSpec at: #normalizeCss ifAbsent: [ String empty ]);
			resetUrl: (frwSpec at: #resetUrl ifAbsent: [ String empty ]);
			themes: (frwSpec at: #themes ifAbsent: [ OrderedCollection empty ]);
			fonts: (frwSpec at: #fontsDir ifAbsent: [ OrderedCollection empty ]) ]
]

{ #category : #'instance creation' }
MicCSSProvider class >> forCSSFrameworkNamed: aString [
	"Answer a <String> representing a remote URL for CSS resource matching aString"

	^ self new 
		initializeWithCSSFramework: aString;
		yourself
		

]

{ #category : #frameworks }
MicCSSProvider class >> frameworks [
	"Answer a <Collection> of available <MicCSSFramework> taken from the receiver's specifications"

	^ Frameworks
		ifNil: [ Frameworks := self defaultFrameworks ]
]

{ #category : #frameworks }
MicCSSProvider class >> frameworksSpecs [

	^ { 
		{ 
		#name -> 'AttriCSS' .
		#minCss -> 'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/midnight-green.css' .
		#repository -> 'https://github.com/raj457036/attriCSS'
		} .
		
		{ 
		#name -> 'AwsmCSS' .
		#minCss -> 'https://raw.githubusercontent.com/igoradamenko/awsm.css/master/dist/awsm.min.css' .
		#repository -> 'https://github.com/igoradamenko/awsm.css'
		} .

		{ 
		#name -> 'Axist' .
		#minCss -> 'https://unpkg.com/axist@latest/dist/axist.min.css' .
		#repository -> 'https://github.com/ruanmartinelli/axist'
		} .
		
		{ 
		#name -> 'Chota' .	
		#minCss -> 'https://unpkg.com/chota@0.8.0/dist/chota.min.css' .
		#repository -> 'https://github.com/jenil/chota'
		} .
		
		{ 
		#name -> 'ClasslessCSS' .	
		#css -> 'https://classless.de/classless.css' .
		#repository -> 'https://github.com/emareg/classlesscss'
		} .
		
		{ 
		#name -> 'ConcreteCSS' .	
		#css -> 'https://unpkg.com/concrete.css' .
		#normalizeCss -> 'https://unpkg.com/normalize.css' .
		#repository -> 'https://github.com/louismerlin/concrete.css'
		} .
		
		{ 
		#name -> 'MercuryCSS' .
		#minCss -> 'https://raw.githubusercontent.com/wmeredith/MercuryCSS/master/css/min/mercury.min.css' .
		#normalizeCss -> 'https://raw.githubusercontent.com/wmeredith/MercuryCSS/master/css/min/normalize.min.css' .
		#repository -> 'https://github.com/wmeredith/MercuryCSS'
		} .
		
		{ 
		#name -> 'MVP' .	
		#css -> 'https://raw.githubusercontent.com/andybrewer/mvp/master/mvp.css' .
		#repository -> 'https://github.com/andybrewer/mvp'
		} .
		
		{ 
		#name -> 'NewCSS' .	
		#minCss -> 'https://cdn.jsdelivr.net/npm/@exampledev/new.css@1/new.min.css' .
		#repository -> 'https://github.com/xz/new.css'
		} .
		
		{ 
		#name -> 'PicnicCSS' .	
		#css -> 'https://cdn.jsdelivr.net/npm/picnic@7.1.0/picnic.css' .
		#repository -> 'https://github.com/franciscop/picnic'
		} .
		
		{ 
		#name -> 'Sakura' .	
		#css -> 'https://raw.githubusercontent.com/oxalorg/sakura/master/css/sakura.css' .
		#repository -> 'https://github.com/oxalorg/sakura'
		} .
		
		{ 
		#name -> 'SimpleCSS' .	
		#minCss -> 'https://cdn.simplecss.org/simple.min.css' .
		#css -> 'https://cdn.simplecss.org/simple.css' .
		#repository -> 'https://github.com/kevquirk/simple.css'
		} .
		
		{ 
		#name -> 'SpCSS' .	
		#minCss -> 'https://raw.githubusercontent.com/susam/spcss/main/sp.min.css' .
		#css -> 'https://cdn.jsdelivr.net/npm/spcss' .
		#repository -> 'https://github.com/susam/spcss'
		} .
		
		{ 
		#name -> 'Splendor' .	
		#minCss -> 'https://raw.githubusercontent.com/markdowncss/splendor/master/css/splendor.min.css' .
		#repository -> 'https://github.com/markdowncss/splendor'
		} .
		
		{ 
		#name -> 'StylizeCSS' .	
		#minCss -> 'https://raw.githubusercontent.com/vasanthv/stylize.css/master/stylize.min.css' .
		#css -> 'https://raw.githubusercontent.com/vasanthv/stylize.css/master/stylize.css' .
		#repository -> 'https://github.com/vasanthv/stylize.css'
		} .
		
		{ 
		#name -> 'Tufte' .	
		#minCss -> 'https://raw.githubusercontent.com/edwardtufte/tufte-css/gh-pages/tufte.min.css' .
		#repository -> 'https://github.com/edwardtufte/tufte-css' .
		#fontsDir -> 'https://github.com/edwardtufte/tufte-css/tree/gh-pages/et-book'
		} .
		
		{ 
		#name -> 'W3C' .	
		#css -> 'https://www.w3.org/StyleSheets/Core/Modernist.css' .
		#repository -> 'https://www.w3.org/StyleSheets/Core/Overview'
		} .
		
		{ 
		#name -> 'WaterCSS' .	
		#minCss -> 'https://cdn.jsdelivr.net/npm/water.css@2/out/water.min.css' .
		#repository -> 'https://github.com/kognise/water.css'
		} .
		
		{ 
		#name -> 'Wing' .	
		#minCss -> 'https://unpkg.com/wingcss@1.0.0-beta/dist/wing.min.css' .
		#repository -> 'https://github.com/kbrsh/wing'
		} .
		
		{ 
		#name -> 'Yorha' .	
		#minCss -> 'https://raw.githubusercontent.com/metakirby5/yorha/master/dist/yorha.min.css' .
		#css -> 'https://raw.githubusercontent.com/metakirby5/yorha/master/dist/yorha.css' .
		#repository -> 'https://github.com/metakirby5/yorha'
		}
		
	} collect: #asDictionary
]

{ #category : #accessing }
MicCSSProvider class >> installFrameworks [
	<script>

	self frameworks do: [ : cssFramework |
		(MicHTMLDoc newWithStyle: cssFramework name)
			destinationDir: 'mic_html_examples';
			fromMicrodown: MicDocFactory exampleMic;
			writeToFileNamed: 'MicExample' , cssFramework name , '.html' ]
]

{ #category : #accessing }
MicCSSProvider >> cssBasePath [

	^ cssBasePath
		ifNil: [ cssBasePath := self defaultCSSBasePath ]
]

{ #category : #accessing }
MicCSSProvider >> cssBasePath: anObject [

	cssBasePath := anObject
]

{ #category : #accessing }
MicCSSProvider >> cssDownloader [

	^ cssDownloader
		ifNil: [ cssDownloader := MicCSSDownloader new ]
]

{ #category : #accessing }
MicCSSProvider >> cssDownloader: anObject [

	cssDownloader := anObject
]

{ #category : #accessing }
MicCSSProvider >> cssFile [

	^ cssFile
]

{ #category : #accessing }
MicCSSProvider >> cssFile: anObject [

	cssFile := anObject
]

{ #category : #accessing }
MicCSSProvider >> cssPath [
	"Answer a <String> describing the location path for the receiver"
	
	^ String streamContents: [ : stream |
		stream 
			<< self cssBasePath;
			<< self cssFile basename ]
]

{ #category : #defaults }
MicCSSProvider >> defaultCSSBasePath [
	"Answer a default <String> describing the location where receiver's CSS files are stored"
	
	^ 'css/'
]

{ #category : #accessing }
MicCSSProvider >> destinationDir [
	"Answer the <String> used as location to store the receiver's CSS files"

	^ destinationDir
		ifNil: [ destinationDir := 'support' ]
]

{ #category : #accessing }
MicCSSProvider >> destinationDir: aPathname [

	destinationDir := aPathname
]

{ #category : #accessing }
MicCSSProvider >> frameworks [
	"Answer a <Collection> of <MicCSSFramework>"

	^ self class frameworks
]

{ #category : #'accessing - downloading' }
MicCSSProvider >> frameworksDirectory [
	"Answer a <FileReference> containing CSS class-less libraries. If no library is found, then download available libraries and retry."

	| libDir |
	^ (libDir := self destinationDir asFileReference) exists
		ifTrue: [ libDir ]
		ifFalse: [ 
			self cssDownloader downloadCSSFrameworks.
			self frameworksDirectory ]
]

{ #category : #initialization }
MicCSSProvider >> initializeWithCSSFramework: aString [
	"Answer a <MicCSSFile> representing a CSS resource matching aString"

	| cssFramework |
	
	cssFramework := self frameworks detect: [ : framework | framework name = aString ].
	cssFramework cssFile: (MicCSSFile new
		fileReference: (self frameworksDirectory / cssFramework preferredCssUrl);
		yourself).
		

]

{ #category : #private }
MicCSSProvider >> writeTo: destDirFileRef [
	"Private - Write receiver's CSS resource into destDirFileRef"

	| fullOutputDir |
	fullOutputDir := (destDirFileRef ensureCreateDirectory / self cssBasePath) ensureCreateDirectory.
	self cssFile copyTo: fullOutputDir / self cssFile basename.

]
