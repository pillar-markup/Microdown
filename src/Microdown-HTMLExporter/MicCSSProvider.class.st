"
As there are many CSS frameworks available each with its own set of features, this class implements a helper for clients to obtain, configure, and query `MicCSSFramework`s. 

Frameworks differ each other in multiple aspects:

  - Each one contains an opinionated style.
  - They are lower or higher-level, intended to be customized or not.
  - Theme provisioning (for example, light & dark modes).
  - It may contain fully responsive layout, which optimizes content to different types of screens.
  - Is provided through a CDN (Content Delivery Network), which are a set of web servers that can deliver commonly-requested content very quickly all over the world, enabling browser caching and dynamic patching.

This class implements behavior to access each framework, and configure its location on the file system. Additionally:

  - It contains a list of specifications for each CSS framework in #frameworkSpecs.
  - It uses a `MicCSSDownloader` as helper to download resources. 
  - Try to download both minified and normal versions of the CSS, if possible. In any case, at leat one should be available

# Usage

## Obtain CSS frameworks

To download a set of pre-defined CSS frameworks, evaluate:

```language=Pharo
MicCSSProvider new installFrameworks.
```

Currently most downloaded frameworks are class-less CSS.

The destination folder where CSS frameworks are downloaded can be configured with #destinationPath:

```language=Pharo
MicCSSProvider new
	destinationPath: 'css_libs';
	installFrameworks
```

If not specified, a default destination folder is set automatically.

## Querying CSS libraries

To inspect the currently available libraries:

```language=Pharo
MicCSSProvider new frameworks.
```

To filter CSS Frameworks with themes:

```language=Pharo
MicCSSProvider new frameworks select: #hasThemes.
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

**Important: After adding a CSS framework, do not forget to download it executing #installFrameworks**


"
Class {
	#name : 'MicCSSProvider',
	#superclass : 'Object',
	#instVars : [
		'cssDownloader',
		'frameworks',
		'destinationPath'
	],
	#category : 'Microdown-HTMLExporter-CSS',
	#package : 'Microdown-HTMLExporter',
	#tag : 'CSS'
}

{ #category : 'accessing' }
MicCSSProvider class >> defaultFramework [
	"Answer a <String> with the name of the CSS library used as default"

	^ 'AwsmCSS'
]

{ #category : 'instance creation' }
MicCSSProvider class >> forCSSNamed: aString [
	"Answer the receiver's <MicCSSFramework> matching aString"

	| provider |
	provider := self new.
	^ provider findCssNamed: aString		

]

{ #category : 'instance creation' }
MicCSSProvider class >> installFrameworks [ 
	<script>

	^ self new installFrameworks inspect.
]

{ #category : 'accessing' }
MicCSSProvider >> cssDownloader [
	"Answer a <MicCSSDownloader>, a helper to download CSS resources"

	^ cssDownloader
		ifNil: [ cssDownloader := self newCssDownloader ]
]

{ #category : 'accessing' }
MicCSSProvider >> cssDownloader: anObject [

	cssDownloader := anObject
]

{ #category : 'frameworks' }
MicCSSProvider >> defaultFrameworks [
	"Answer a <Collection> of available <MicCSSFramework> taken from the receiver's specifications"

	^ self frameworksSpecs collect: [ : frwSpec |
		self newCssFrameworkFrom: frwSpec ]
]

{ #category : 'accessing' }
MicCSSProvider >> destinationPath [
	"Answer a <String> used as location to store the receiver's CSS frameworks"

	^ destinationPath
		ifNil: [ destinationPath := 'support' ]
]

{ #category : 'accessing' }
MicCSSProvider >> destinationPath: aPathname [

	destinationPath := aPathname
]

{ #category : 'initialization' }
MicCSSProvider >> findCssNamed: aString [
	"Answer a <MicCSSFramework> matching aString"
	
	^ self frameworks 
		detect: [ : framework | framework name = aString ]
]

{ #category : 'frameworks' }
MicCSSProvider >> frameworks [
	"Answer a <Collection> of available <MicCSSFramework> taken from the receiver's specifications"

	^ frameworks
		ifNil: [ frameworks := self defaultFrameworks ]
]

{ #category : 'frameworks' }
MicCSSProvider >> frameworksSpecs [
	"Answer a <Collection> of <Array> representing specifications for building CSS framework objects.
	Re-execute #installFrameworks after modifying this method."

	^ { 
		{ 
		#name -> 'AttriCSS' .
		#minCss -> 'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/brightlight-green.css' .
		#repository -> 'https://github.com/raj457036/attriCSS' .
		#themes -> ({ 
			{ 
			#name -> 	'Brightlight Green' .
			#minCss -> 'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/brightlight-green.css' 
			} .
			{ 
			#name -> 'Dark Fairy Pink' .
			#minCss -> 'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/darkfairy-pink.css' 
			} .
			{ 
			#name -> 'Dark Forest Green' .
			#minCss -> 'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/darkforest-green.css'
			} .
			{ 
			#name -> 'Light Fairy Pink' .
			#minCss ->  'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/lightfairy-pink.css' 
			} .
			{ 
			#name -> 'Midnight Green' .
			#minCss -> 'https://raw.githubusercontent.com/raj457036/attriCSS/master/themes/midnight-green.css' 
			} } collect: #asDictionary)
		} .
		
		{ 
		#name -> 'AwsmCSS' .
		#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm.css' .
		#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm.min.css' .
		#repository -> 'https://github.com/igoradamenko/awsm.css' .
		#themes -> ({
			{ 
			#name -> 'White' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_white.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_white.min.css'
			} .
			{ 
			#name -> 	'Gondola' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_gondola.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_gondola.min.css' 
			} .
			{ 
			#name -> 'Mischnka' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_mischka.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_mischka.min.css' 
			} .
			{ 
			#name -> 'Big Stone' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_big-stone.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_big-stone.min.css'
			} .
			{ 
			#name -> 'Black' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_black.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_black.min.css'
			} .
			{ 
			#name -> 'Tasman' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_tasman.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_tasman.min.css'
			} .
			{ 
			#name -> 'Pastel Pink' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_pastel-pink.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_pastel-pink.min.css' 
			} .
			{ 
			#name -> 'Pearl Lusta' .
			#css -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_pearl-lusta.css' .
			#minCss -> 'https://igoradamenko.github.io/awsm.css/css/awsm_theme_pearl-lusta.min.css'
			 } } collect: #asDictionary)
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
		#minCss -> 'https://classless.de/classless-tiny.css' .
		#repository -> 'https://github.com/emareg/classlesscss' .
		#themes -> ({ 
			{ 
			#name -> 'Theme' . 
			#css -> 'https://classless.de/addons/themes.css'
			} } collect: #asDictionary)
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
		#repository -> 'https://github.com/xz/new.css' .
		#themes -> ({ 
			{ 
			#name -> 'Night' .
			#css -> 'https://newcss.net/theme/night.css'
			} .
			{ 
			#name -> 'Terminal' .
			#css ->  'https://newcss.net/theme/terminal.css'
			}
			} collect: #asDictionary)
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
		#repository -> 'https://github.com/kognise/water.css' .
		#themes -> ({
			{ 
			#name -> 'Dark' . 
			#minCss -> 'https://cdn.jsdelivr.net/npm/water.css@2/out/dark.min.css' 
			} .
			{ 
			#name -> 'Light' .
			#minCss -> 'https://cdn.jsdelivr.net/npm/water.css@2/out/light.min.css' 
			} } collect: #asDictionary)
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
		} .
		
		{ 
		#name -> 'LaTeX' .
		#css -> 'https://latex.vercel.app/style.css' .
		#minCss -> 'https://unpkg.com/latex.css/style.min.css' .
		#repository -> 'https://github.com/vincentdoerig/latex-css' 
		}
		
	} collect: #asDictionary
]

{ #category : 'testing' }
MicCSSProvider >> hasFrameworksInstalled [
	"Answer <true> if frameworks has been installed in the receiver's destination path"
	
	| destFileRef |
	
	destFileRef := self destinationPath asFileReference.
	^ destFileRef exists and: [ destFileRef entries anySatisfy: [ : entry | entry reference extension = 'css' ] ]
]

{ #category : 'accessing' }
MicCSSProvider >> installFrameworks [
	"Download CSS libraries to local system"

	self destinationPath asFileReference exists
		ifTrue: [ self destinationPath asFileReference ensureDeleteAll ].
	self cssDownloader downloadCSSFrameworks
]

{ #category : 'accessing' }
MicCSSProvider >> newCssDownloader [
	"Answer a new <MicCSSDownloader> configured to download resources in the receiver's destination directory"

	^ MicCSSDownloader new
		cssProvider: self;
		yourself
]

{ #category : 'private' }
MicCSSProvider >> newCssFrameworkFrom: frwSpec [

	^ MicCSSFramework new
		name: (frwSpec at: #name);
		newCssFiles: frwSpec;
		destinationPath: self destinationPath;		
		projectUrl: (frwSpec at: #repository);
		cssUrl: (frwSpec at: #css ifAbsent: [ String empty ]);
		minCssUrl: (frwSpec at: #minCss ifAbsent: [ String empty ]);
		normalizeUrl: (frwSpec at: #normalizeCss ifAbsent: [ String empty ]);
		resetUrl: (frwSpec at: #resetUrl ifAbsent: [ String empty ]);
		themes: (frwSpec at: #themes ifAbsent: [ OrderedCollection empty ]);
		fonts: (frwSpec at: #fontsDir ifAbsent: [ OrderedCollection empty ]);
		yourself
]
