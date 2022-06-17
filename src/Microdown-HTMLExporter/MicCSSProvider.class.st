"
Class side includes methods (protocol named ""libraries"") containing metadata for pre-defined class-less CSS libraries, where each CSS library is represented by a method. This metadata is used to download CSS libraries in a local directory. If not specified, a default destination folder is set automatically.

# Usage

## Download CSS libraries

To download a set of pre-defined class-less CSS libraries, evaluate:

```
MicCSSLocalProvider getCSSLibs.
```

The destination folder where CSS libraries are downloaded can be configured with #destinationDir:

```
MicCSSLocalProvider 
	destinationDir: 'css_libs';
	getCSSLibs
```

## Querying CSS libraries


To inspect the currently available libraries:

```
MicCSSProvider librarySelectors.
```

To list a Collection of the remote URL resource for each available CSS library:

```
MicCSSProvider librariesMetadata.
```

## Adding a CSS library

To add a new library, add a new method to the class side category _libraries_. The method should answer a Collection of Associations. At least one of the two following keys must exist: #minCss or #css.

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
		'cssBasePath'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #libraries }
MicCSSProvider class >> attricss [

	^ { 
		#name -> 'AttriCSS' .
		#minCss -> 'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/midnight-green.css' .
		#repository -> 'https://github.com/raj457036/attriCSS'
		}
]

{ #category : #libraries }
MicCSSProvider class >> awsmcss [

	^ { 
		#name -> 'AwsmCSS' .
		#minCss -> 'https://raw.githubusercontent.com/igoradamenko/awsm.css/master/dist/awsm.min.css' .
		#repository -> 'https://github.com/igoradamenko/awsm.css'
		}
]

{ #category : #libraries }
MicCSSProvider class >> axist [

	^ { 
		#name -> 'Axist' .
		#minCss -> 'https://unpkg.com/axist@latest/dist/axist.min.css' .
		#repository -> 'https://github.com/ruanmartinelli/axist'
		}
]

{ #category : #accessing }
MicCSSProvider class >> baseDirectory [
	" Answer a <FileReference> to store the receiver's libraries"

	^ FileLocator imageDirectory
]

{ #category : #libraries }
MicCSSProvider class >> chota [

	^ { 
		#name -> 'Chota' .	
		#minCss -> 'https://unpkg.com/chota@0.8.0/dist/chota.min.css' .
		#repository -> 'https://github.com/jenil/chota'
		}
]

{ #category : #libraries }
MicCSSProvider class >> classlesscss [

	^ { 
		#name -> 'ClasslessCSS' .	
		#css -> 'https://classless.de/classless.css' .
		#repository -> 'https://github.com/emareg/classlesscss'
		}
]

{ #category : #libraries }
MicCSSProvider class >> concretecss [

	^ { 
		#name -> 'ConcreteCSS' .	
		#css -> 'https://unpkg.com/concrete.css' .
		#normalizeCss -> 'https://unpkg.com/normalize.css' .
		#repository -> 'https://github.com/louismerlin/concrete.css'
		}
]

{ #category : #accessing }
MicCSSProvider class >> installExamples [
	<script>

	self libraryNames do: [ : libName |
		(MicHTMLDoc newWithStyle: libName)
			destinationDir: 'mic_html_examples';
			fromMicrodown: MicDocFactory exampleMic;
			writeToFileNamed: 'MicExample' , libName , '.html' ]
]

{ #category : #accessing }
MicCSSProvider class >> libAttributesFor: selector [
	"Answer a <Dictionary> for receiver's method selector"

	^ (self perform: selector) asDictionary.
]

{ #category : #accessing }
MicCSSProvider class >> libraryNames [
	"Answer a <Collection> of <String> each representing a classless CSS library name"

	^ self librarySelectors collect: [ : selector |
		(self libAttributesFor: selector) at: #name ]
]

{ #category : #accessing }
MicCSSProvider class >> librarySelectors [
	"Answer a <Collection> of <Symbol> matching selectors for CSS libraries"
	
	^ MicCSSProvider class organization listAtCategoryNamed: #libraries
]

{ #category : #libraries }
MicCSSProvider class >> mercurycss [

	^ { 
		#name -> 'MercuryCSS' .
		#minCss -> 'https://raw.githubusercontent.com/wmeredith/MercuryCSS/master/css/min/mercury.min.css' .
		#normalizeCss -> 'https://raw.githubusercontent.com/wmeredith/MercuryCSS/master/css/min/normalize.min.css' .
		#repository -> 'https://github.com/wmeredith/MercuryCSS'
		}
]

{ #category : #libraries }
MicCSSProvider class >> mvp [

	^ { 
		#name -> 'MVP' .	
		#css -> 'https://raw.githubusercontent.com/andybrewer/mvp/master/mvp.css' .
		#repository -> 'https://github.com/andybrewer/mvp'
		}
]

{ #category : #'instance creation' }
MicCSSProvider class >> named: aString [
	"Answer a <String> representing a remote URL for CSS resource matching aString"

	^ self new 
		initializeWithCSSLibrary: aString;
		yourself
		

]

{ #category : #libraries }
MicCSSProvider class >> newcss [

	^ { 
		#name -> 'NewCSS' .	
		#minCss -> 'https://cdn.jsdelivr.net/npm/@exampledev/new.css@1/new.min.css' .
		#repository -> 'https://github.com/xz/new.css'
		}
]

{ #category : #libraries }
MicCSSProvider class >> picniccss [

	^ { 
		#name -> 'PicnicCSS' .	
		#css -> 'https://cdn.jsdelivr.net/npm/picnic@7.1.0/picnic.css' .
		#repository -> 'https://github.com/franciscop/picnic'
		}
]

{ #category : #libraries }
MicCSSProvider class >> picocss [

	^ { 
		#name -> 'PicoCSS' .	
		#minCss -> 'https://unpkg.com/@picocss/pico@latest/css/pico.classless.min.css' .
		#fluidCss -> 'https://unpkg.com/@picocss/pico@latest/css/pico.fluid.classless.min.css' .
		#repository -> 'https://github.com/picocss/pico'
		}
]

{ #category : #libraries }
MicCSSProvider class >> sakura [

	^ { 
		#name -> 'Sakura' .	
		#css -> 'https://raw.githubusercontent.com/oxalorg/sakura/master/css/sakura.css' .
		#repository -> 'https://github.com/oxalorg/sakura'
		}
]

{ #category : #libraries }
MicCSSProvider class >> simplecss [

	^ { 
		#name -> 'SimpleCSS' .	
		#minCss -> 'https://cdn.simplecss.org/simple.min.css' .
		#css -> 'https://cdn.simplecss.org/simple.css' .
		#repository -> 'https://github.com/kevquirk/simple.css'
		}
]

{ #category : #libraries }
MicCSSProvider class >> spcss [

	^ { 
		#name -> 'SpCSS' .	
		#minCss -> 'https://raw.githubusercontent.com/susam/spcss/main/sp.min.css' .
		#css -> 'https://cdn.jsdelivr.net/npm/spcss' .
		#repository -> 'https://github.com/susam/spcss'
		}
]

{ #category : #libraries }
MicCSSProvider class >> splendor [

	^ { 
		#name -> 'Splendor' .	
		#minCss -> 'https://raw.githubusercontent.com/markdowncss/splendor/master/css/splendor.min.css' .
		#repository -> 'https://github.com/markdowncss/splendor'
		}
]

{ #category : #libraries }
MicCSSProvider class >> stylizecss [

	^ { 
		#name -> 'StylizeCSS' .	
		#minCss -> 'https://raw.githubusercontent.com/vasanthv/stylize.css/master/stylize.min.css' .
		#css -> 'https://raw.githubusercontent.com/vasanthv/stylize.css/master/stylize.css' .
		#repository -> 'https://github.com/vasanthv/stylize.css'
		}
]

{ #category : #libraries }
MicCSSProvider class >> tufte [

	^ { 
		#name -> 'Tufte' .	
		#minCss -> 'https://raw.githubusercontent.com/edwardtufte/tufte-css/gh-pages/tufte.min.css' .
		#repository -> 'https://github.com/edwardtufte/tufte-css' .
		#fontsDir -> 'https://github.com/edwardtufte/tufte-css/tree/gh-pages/et-book'
		}
]

{ #category : #libraries }
MicCSSProvider class >> w3c [

	^ { 
		#name -> 'W3C' .	
		#css -> 'https://www.w3.org/StyleSheets/Core/Modernist.css' .
		#repository -> 'https://www.w3.org/StyleSheets/Core/Overview'
		}
]

{ #category : #libraries }
MicCSSProvider class >> watercss [

	^ { 
		#name -> 'WaterCSS' .	
		#minCss -> 'https://cdn.jsdelivr.net/npm/water.css@2/out/water.min.css' .
		#repository -> 'https://github.com/kognise/water.css'
		}
]

{ #category : #libraries }
MicCSSProvider class >> wing [

	^ { 
		#name -> 'Wing' .	
		#minCss -> 'https://unpkg.com/wingcss@1.0.0-beta/dist/wing.min.css' .
		#repository -> 'https://github.com/kbrsh/wing'
		}
]

{ #category : #libraries }
MicCSSProvider class >> yorha [

	^ { 
		#name -> 'Yorha' .	
		#minCss -> 'https://raw.githubusercontent.com/metakirby5/yorha/master/dist/yorha.min.css' .
		#css -> 'https://raw.githubusercontent.com/metakirby5/yorha/master/dist/yorha.css' .
		#repository -> 'https://github.com/metakirby5/yorha'
		}
]

{ #category : #'accessing - downloading' }
MicCSSProvider >> assertNonBinaryResponse: response [ 
	
	response contentType isBinary 
		ifTrue: [ Error signal: 'Did not expect a binary response but got ', response contentType printString ].
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

{ #category : #accessing }
MicCSSProvider >> cssResource: libAttributes [
	"Answer a <String> representing the URL of the CSS resource specified in libAttributes Dictionary"

	^ libAttributes 
			at: #minCss 
			ifAbsent: [
				libAttributes 
					at: #css
					ifAbsent: [ nil ] ]
]

{ #category : #defaults }
MicCSSProvider >> defaultCSSBasePath [
	"Answer a default <String> describing the location where receiver's CSS files are stored"
	
	^ 'css/'
]

{ #category : #accessing }
MicCSSProvider >> destinationDir [

	^ destinationDir
		ifNil: [ destinationDir := 'support' ]
]

{ #category : #accessing }
MicCSSProvider >> destinationDir: aPathname [

	destinationDir := aPathname
]

{ #category : #private }
MicCSSProvider >> detectLibraryNamed: aString [
	"Answer a <Symbol> representing a selector matching aString. A selector is searched in the receiver whose name
	matches aString, both of them are normalized. If we cannot find aString as a library, then raise a not found exception."
	
	^ self librarySelectors 
		detect: [ : selector | ((self libAttributesFor: selector) at: #name) asLowercase = aString asLowercase ]
]

{ #category : #'accessing - downloading' }
MicCSSProvider >> getCSSLib: cssLibSelector [
	"Download a CSS library using information provided in cssLibSelector method. Prioritize minified versions."

	| cssLibDict |

	cssLibDict := self libAttributesFor: cssLibSelector.
	(cssLibDict includesKey: #minCss)
		ifTrue: [ self getCSSLibFrom: (cssLibDict at: #minCss) ]
		ifFalse: [ 
			(cssLibDict includesKey: #css)
				ifTrue: [ self getCSSLibFrom: (cssLibDict at: #css) ] ]
]

{ #category : #'accessing - downloading' }
MicCSSProvider >> getCSSLibFrom: anURLString [ 

	| client |

	(client := self httpClient) get: anURLString.
	self assertNonBinaryResponse: client response.
	self 
		installCss: client response contents
		named: client requestedResource
]

{ #category : #'accessing - downloading' }
MicCSSProvider >> getCSSLibs [
	"Download CSS libraries specified in the class protocol of the receiver, and install them on disk.
	We download both minified and normal versions of the CSS, if possible. In any case, at leat one should be available"

	self librarySelectors 
		do: [ : cssLibSelector | self getCSSLib: cssLibSelector ]
		displayingProgress: 'Downloading CSS libraries'
]

{ #category : #'accessing - downloading' }
MicCSSProvider >> httpClient [
	"Return a new, specifically configured instance of the HTTP client for internal use.
	Note how we request GZIP compression and will signal progress."

	^ ZnClient new
		systemPolicy;
		beOneShot;
		signalProgress: true;
		ifFail: [ :exception | self error: 'Could not load : ', exception printString ];
		yourself
]

{ #category : #initialization }
MicCSSProvider >> initializeWithCSSLibrary: aString [
	"Answer a <MicCSSFile> representing a CSS resource matching aString"

	| cssFilename |
	
	cssFilename := (self urlForLibraryNamed: aString) pathSegments last.
	self cssFile: (MicCSSFile new
		fileReference: (self librariesDirectory / cssFilename);
		yourself).
		

]

{ #category : #'accessing - downloading' }
MicCSSProvider >> installCss: cssString named: cssLibName [
	"Install all CSS <String> in baseDirectory as cssLibName"

	| destination |
	destination := self librariesDirectory.
	destination 	ensureCreateDirectory.
	(destination / cssLibName) asFileReference 
		ensureDelete;
		writeStreamDo: [ : writeStream | writeStream << cssString ].

]

{ #category : #accessing }
MicCSSProvider >> libAttributesFor: selector [
	"Answer a <Dictionary> for receiver's method selector"
	
	^ self class libAttributesFor: selector
]

{ #category : #'accessing - downloading' }
MicCSSProvider >> librariesDirectory [
	"Answer a <FileReference> containing CSS class-less libraries"

	^ self destinationDir asFileReference
]

{ #category : #accessing }
MicCSSProvider >> librariesMetadata [
	"Answer a <Collection> of <Association>"

	^ self librarySelectors collect: [ : selector |
		selector -> (self cssResource: (self libAttributesFor: selector)) ]
]

{ #category : #accessing }
MicCSSProvider >> librarySelectors [
	"Answer a <Collection> of <Symbol> matching selectors for CSS libraries"
	
	^ self class librarySelectors
]

{ #category : #'writing - css' }
MicCSSProvider >> serializeCSSIn: destDirFileRef [
	"Private - Serialize receiver's CSS resource into destDirFileRef"

	destDirFileRef ensureCreateDirectory.
	(destDirFileRef / self cssPath) ensureCreateDirectory.
	self cssFile copyTo: destDirFileRef / self cssPath.

]

{ #category : #private }
MicCSSProvider >> urlForLibraryNamed: aString [
	"Answer a <ZnUrl> representing the preferred URL for the receiver"

	| libSelector |
	libSelector :=  self detectLibraryNamed: aString.
	^ (self cssResource: (self libAttributesFor: libSelector)) asZnUrl
]
