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

	| local |
	local := self localRepositoryPath.

	^ {
		  {
			  (#name -> 'AttriCSS').
			  (#minCss -> (self localCSSNamed: 'brightlight-green.css')).
			  (#repository -> 'https://github.com/raj457036/attriCSS').
			  (#themes -> ({
				    {
					    (#name -> 'Brightlight Green').
					    (#minCss -> (self localCSSNamed: 'brightlight-green.css')) }.
				    {
					    (#name -> 'Dark Fairy Pink').
					    (#minCss -> (self localCSSNamed: 'darkfairy-pink.css')) }.
				    {
					    (#name -> 'Dark Forest Green').
					    (#minCss -> (self localCSSNamed: 'darkforest-green.css')) }.
				    {
					    (#name -> 'Light Fairy Pink').
					    (#minCss -> (self localCSSNamed: 'lightfairy-pink.css')) }.
				    {
					    (#name -> 'Midnight Green').
					    (#minCss -> (self localCSSNamed: 'midnight-green.css')) } }
				    collect: #asDictionary)) }.

		  {
			  (#name -> 'AwsmCSS').
			  (#css -> (self localCSSNamed: 'awsm.css')).
			  (#minCss -> (self localCSSNamed: 'awsm.min.css')).
			  (#repository -> (self localCSSNamed: 'awsm.css')).
			  (#themes -> ({
				    {
					    (#name -> 'White').
					    (#css -> (self localCSSNamed: 'awsm_theme_white.css')).
					    (#minCss -> (self localCSSNamed: 'awsm_theme_white.min.css')) }.
				    {
					    (#name -> 'Gondola').
					    (#css -> (self localCSSNamed: 'awsm_theme_gondola.css')).
					    (#minCss
					     -> (self localCSSNamed: 'awsm_theme_gondola.min.css')) }.
				    {
					    (#name -> 'Mischnka').
					    (#css -> (self localCSSNamed: 'awsm_theme_mischka.css')).
					    (#minCss
					     -> (self localCSSNamed: 'awsm_theme_mischka.min.css')) }.
				    {
					    (#name -> 'Big Stone').
					    (#css -> (self localCSSNamed: 'awsm_theme_big-stone.css')).
					    (#minCss
					     -> (self localCSSNamed: 'awsm_theme_big-stone.min.css')) }.
				    {
					    (#name -> 'Black').
					    (#css -> (self localCSSNamed: 'awsm_theme_black.css')).
					    (#minCss -> (self localCSSNamed: 'awsm_theme_black.min.css')) }.
				    {
					    (#name -> 'Tasman').
					    (#css -> (self localCSSNamed: 'awsm_theme_tasman.css')).
					    (#minCss -> (self localCSSNamed: 'awsm_theme_tasman.min.css')) }.
				    {
					    (#name -> 'Pastel Pink').
					    (#css -> (self localCSSNamed: 'awsm_theme_pastel-pink.css')).
					    (#minCss
					     -> (self localCSSNamed: 'awsm_theme_pastel-pink.min.css')) }.
				    {
					    (#name -> 'Pearl Lusta').
					    (#css -> (self localCSSNamed: 'awsm_theme_pearl-lusta.css')).
					    (#minCss
					     -> (self localCSSNamed: 'awsm_theme_pearl-lusta.min.css')) } }
				    collect: #asDictionary)) }.

		  {
			  (#name -> 'Axist').
			  (#minCss -> (self localCSSNamed: 'axist.min.css')).
			  (#repository -> 'https://github.com/ruanmartinelli/axist') }.

		  {
			  (#name -> 'Chota').
			  (#minCss -> (self localCSSNamed: 'chota.min.css')).
			  (#repository -> 'https://github.com/jenil/chota') }.

		  {
			  (#name -> 'ClasslessCSS').
			  (#css -> (self localCSSNamed: 'classless.css')).
			  (#minCss -> (self localCSSNamed: 'classless-tiny.css')).
			  (#repository -> 'https://github.com/emareg/classlesscss').
			  (#themes -> ({ {
				    (#name -> 'Theme').
				    (#css -> (self localCSSNamed: 'themes.css')) } } collect:
				    #asDictionary)) }.

		  {
			  (#name -> 'ConcreteCSS').
			  (#css -> (self localCSSNamed: 'concrete.css')).
			  (#normalizeCss -> (self localCSSNamed: 'normalize.css')).
			  (#repository -> (self localCSSNamed: 'concrete.css')) }.

		  {
			  (#name -> 'MercuryCSS').
			  (#minCss -> (self localCSSNamed: 'mercury.min.css')).
			  (#normalizeCss -> (self localCSSNamed: 'normalize.min.css')).
			  (#repository
			   ->
			   (self localCSSNamed: 'https://github.com/wmeredith/MercuryCSS')) }.

		  {
			  (#name -> 'MVP').
			  (#css -> (self localCSSNamed: 'mvp.css')).
			  (#repository -> 'https://github.com/andybrewer/mvp') }.

		  {
			  (#name -> 'NewCSS').
			  (#minCss -> (self localCSSNamed: 'new.min.css')).
			  (#repository -> (self localCSSNamed: 'new.css')).
			  (#themes -> ({
				    {
					    (#name -> 'Night').
					    (#css -> (self localCSSNamed: 'night.css')) }.
				    {
					    (#name -> 'Terminal').
					    (#css -> (self localCSSNamed: 'terminal.css')) } } collect:
				    #asDictionary)) }.

		  {
			  (#name -> 'PicnicCSS').
			  (#css -> (self localCSSNamed: 'picnic.css')).
			  (#repository -> 'https://github.com/franciscop/picnic') }.

		  {
			  (#name -> 'Sakura').
			  (#css -> (self localCSSNamed: 'sakura.css')).
			  (#repository -> 'https://github.com/oxalorg/sakura') }.

		  {
			  (#name -> 'SimpleCSS').
			  (#minCss -> (self localCSSNamed: 'simple.min.css')).
			  (#css -> (self localCSSNamed: 'simple.css')).
			  (#repository -> (self localCSSNamed: 'simple.css')) }.

		  {
			  (#name -> 'SpCSS').
			  (#minCss -> (self localCSSNamed: 'sp.min.css')).
			  (#css -> (self localCSSNamed: 'spcss')).
			  (#repository -> 'https://github.com/susam/spcss') }.

		  {
			  (#name -> 'Splendor').
			  (#minCss -> (self localCSSNamed: 'splendor.min.css')).
			  (#repository -> 'https://github.com/markdowncss/splendor') }.

		  {
			  (#name -> 'StylizeCSS').
			  (#minCss -> (self localCSSNamed: 'stylize.min.css')).
			  (#css -> (self localCSSNamed: 'stylize.css')).
			  (#repository -> (self localCSSNamed: 'stylize.css')) }.

		  {
			  (#name -> 'Tufte').
			  (#minCss -> (self localCSSNamed: 'tufte.min.css')).
			  (#repository -> 'https://github.com/edwardtufte/tufte-css').
			  (#fontsDir
			   ->
			   'https://github.com/edwardtufte/tufte-css/tree/gh-pages/et-book') }.

		  {
			  (#name -> 'W3C').
			  (#css -> (self localCSSNamed: 'Modernist.css')).
			  (#repository -> 'https://www.w3.org/StyleSheets/Core/Overview') }.

		  {
			  (#name -> 'WaterCSS').
			  (#minCss -> (self localCSSNamed: 'water.min.css')).
			  (#repository -> (self localCSSNamed: 'water.css')).
			  (#themes -> ({
				    {
					    (#name -> 'Dark').
					    (#minCss -> (self localCSSNamed: 'dark.min.css')) }.
				    {
					    (#name -> 'Light').
					    (#minCss -> (self localCSSNamed: 'light.min.css')) } }
				    collect: #asDictionary)) }.

		  {
			  (#name -> 'Wing').
			  (#minCss -> (self localCSSNamed: 'wing.min.css')).
			  (#repository -> 'https://github.com/kbrsh/wing') }.

		  {
			  (#name -> 'Yorha').
			  (#minCss -> (self localCSSNamed: 'yorha.min.css')).
			  (#css -> (self localCSSNamed: 'yorha.css')).
			  (#repository -> 'https://github.com/metakirby5/yorha') }.

		  {
			  (#name -> 'LaTeX').
			  (#css -> (self localCSSNamed: 'style.css')).
			  (#minCss -> (self localCSSNamed: 'style.min.css')).
			  (#repository -> 'https://github.com/vincentdoerig/latex-css') } }
		  collect: #asDictionary
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

{ #category : 'frameworks' }
MicCSSProvider >> localCSSNamed: aString [

	^ (self localRepositoryPath / aString) fullName
]

{ #category : 'frameworks' }
MicCSSProvider >> localRepositoryPath [ 

	^ FileSystem workingDirectory / 'pharo-local' / 'iceberg' / 'pillar-markup' / 'Microdown' / 'ressource'
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
