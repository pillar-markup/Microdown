"
Acts as a repository contains remote metadata off class-less CSS libraries.
Class methods includes methods containing metadata for each library, where each CSS library is represented by a method. 

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
		'directory',
		'name'
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
MicCSSProvider class >> cssResource: libAttributes [
	"Answer a <String> representing the URL of the CSS resource specified in libAttributes Dictionary"

	^ libAttributes 
			at: #minCss 
			ifAbsent: [
				libAttributes 
					at: #css
					ifAbsent: [ nil ] ]
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
MicCSSProvider class >> librariesMetadata [
	"Answer a <Collection> of <Association>"

	^ self librarySelectors collect: [ : selector |
		selector -> (self cssResource: (self libAttributesFor: selector)) ]
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

{ #category : #accessing }
MicCSSProvider class >> named: aString [
	"Answer a <String> representing a remote URL for CSS resource matching aString"

	| libName |
	libName :=  (MicCSSProvider librarySelectors 
		detect: [ : selector | ((self libAttributesFor: selector) at: #name) asLowercase = aString asLowercase ]).
	^ self cssResource: (self libAttributesFor: libName)
		

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
