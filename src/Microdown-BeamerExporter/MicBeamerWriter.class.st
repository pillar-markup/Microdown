"
I export mainly slides in Beamer LaTeX. 
Slides are expressed as MicSlideBlock nodes whose surface syntax use the Pharo extension facilities (`<!slide|title   body !>`).

Note that I do not generate the full beamer but the body of the slides. The beamer template can be for example the one of Pillar/presentation. 


```
| doc dict aFileReference output| 
doc := Microdown parse: MicMicrodownSnippetFactory new oneSlide.
dict := Dictionary new. 
dict at: 'content' put: (MicBeamerWriter new visit: doc).
dict at: 'title' put: 'ZeCrazy slides'.

output := (MustacheTemplate 
	on: '/Users/ducasse/.pillar/build/archetypes/presentation/support/templates/beamer/presentation.template' asFileReference readStream contents)
	value: dict.

aFileReference := FileSystem workingDirectory / 'MyCoolPresentation.tex'.
aFileReference ensureDelete.
aFileReference parent ensureCreateDirectory.
aFileReference writeStreamDo: [ :stream | 
		stream nextPutAll: output ]
```


```
| doc dict aFileReference output| 
doc := Microdown parse: MicMicrodownSnippetFactory new oneSlide.
dict := Dictionary new. 
dict at: 'content' put: (MicBeamerWriter new visit: doc).
dict at: 'title' put: 'ZeCrazy slides'.

output := (MustacheTemplate on: MicBeamerWriter basicTemplateForTest) value: dict.

aFileReference := FileSystem workingDirectory / 'MyCoolPresentation.tex'.
aFileReference ensureDelete.
aFileReference parent ensureCreateDirectory.
aFileReference writeStreamDo: [ :stream | 
		stream nextPutAll: output ]
```

### How to load mustache

```
Metacello new
  baseline: 'Mustache';
  repository: 'github://noha/mustache:v1.0/repository';
  load
```
"
Class {
	#name : 'MicBeamerWriter',
	#superclass : 'MicLaTeXWriter',
	#category : 'Microdown-BeamerExporter-Slide',
	#package : 'Microdown-BeamerExporter',
	#tag : 'Slide'
}

{ #category : 'basic ressources' }
MicBeamerWriter class >> basicTemplateForTest [

	^ '% -*- mode: latex; -*- mustache tags: {{=« »=}} «! the ''&'' below prevents HTML escaping. »

\documentclass{beamer}

\usepackage[frenchb]{babel}
\usepackage[T1]{fontenc}
\usepackage{pgfpages}
\usepackage{listings}
\usepackage{color}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{mystyle}{
    backgroundcolor=\color{backcolour},
    numberstyle=\tiny\color{codegreen},
    breaklines=true,
    captionpos=b,
    tabsize=2,
    basicstyle=\ttfamily\scriptsize
}

\lstset{style=mystyle}

\usetheme{Warsaw}

\setbeamercolor{structure}{fg=red!90!black}

\title{«& title»}
\subtitle{«& subtitle»}
\author{«& author»}
\institute{«& complement»}
\date{«& date»}

\addtobeamertemplate{navigation symbols}{}{%
    \usebeamerfont{footline}%
    \usebeamercolor[fg]{footline}%
    \hspace{1em}%
    \insertframenumber/\inserttotalframenumber
}

\setbeamercolor{footline}{fg=blue}
\setbeamerfont{footline}{series=\bfseries}
\setbeamertemplate{headline}{}

\begin{document}

    \frame[plain]{\titlepage}
    \frame[plain]{\tableofcontents}

    «& content»
\end{document}'
]

{ #category : 'accessing' }
MicBeamerWriter class >> writerName [

	^ #micBeamer
]

{ #category : 'helpers' }
MicBeamerWriter >> createFrametitle: aTitle [
	canvas command
		name: 'frametitle';
		parameter: aTitle
]

{ #category : 'helpers' }
MicBeamerWriter >> createLinkToLabelWithAlias: anInternalLink [
	canvas command
		name: 'hyperlink';
		parameter: [ canvas raw: anInternalLink anchor ];
		parameter: [ canvas raw: anInternalLink alias ]
]

{ #category : 'accessing' }
MicBeamerWriter >> folderName [
	^ #beamer
]

{ #category : 'helpers' }
MicBeamerWriter >> sectionOptionFrom: level To: depth On: parameters [
	parameters
		add:
			((1 > level and: [ 1 <= depth ])
				ifTrue: [ 'sectionstyle=show/show' ]
				ifFalse: [ 'sectionstyle=hide/hide' ]).
	parameters
		add:
			((2 > level and: [ 2 <= depth ])
				ifTrue: [ 'subsectionstyle=show/show/show' ]
				ifFalse: [ 'subsectionstyle=hide/hide/hide' ]).
	parameters
		add:
			((3 > level and: [ 3 <= depth ])
				ifTrue: [ 'subsubsectionstyle=show/show/show' ]
				ifFalse: [ 'subsubsectionstyle=hide/hide/hide' ])
]

{ #category : 'accessing' }
MicBeamerWriter >> templateForConfiguration: aConfiguration [
	^ 'presentation.template'
]

{ #category : 'blocks - code' }
MicBeamerWriter >> visitCode: aCodeBlock [
	"Pay attention that we should generate 
	\begin{listing}{} and not {listing}"
	
	| env |
	env := (aCodeBlock hasCaption and: [ aCodeBlock hasAnchor ])
		       ifTrue: [
			       canvas environment
				       name: 'listing';
				       optParameter: 'label=' , aCodeBlock label;
				       optParameter:
					       'caption={'
					       , (self getStringForAll: aCodeBlock captionElements) , '}';
				       yourself ]
		       ifFalse: [
			       env := aCodeBlock hasCaption
				              ifTrue: [
					              canvas environment
						              name: 'listing';
						              optParameter:
							              'caption={'
							              ,
								              (self getStringForAll:
										               aCodeBlock captionElements) , '}';
						              yourself ]
				              ifFalse: [
					              env := aCodeBlock hasAnchor
						                     ifTrue: [
							                     canvas environment
								                     name: 'listing';
								                     optParameter:
									                     'label=' , aCodeBlock anchor;
								                     yourself ]
						                     ifFalse: [
							                     canvas environment
								                     name: 'listing';
								                     parameter: ''; "important else it will breaks"
								                     yourself ] ] ].
	env with: [
		self writeRawDuring: [ canvas nextPutAllLines: aCodeBlock body ].
			canvas newLine ].

]

{ #category : 'visiting' }
MicBeamerWriter >> visitColumn: aColumn [
	canvas environment
		name: 'column';
		parameter: [ 
					canvas
						nextPutAll: (aColumn width asNumber / 100.0) printString;
						raw: '\textwidth' ];
		with: [ self visitAll: aColumn children ].
	canvas newLine
]

{ #category : 'visiting' }
MicBeamerWriter >> visitColumns: aColumns [
	canvas environment
		name: 'columns';
		with: [ 
					self visitAll: aColumns children].
	canvas newLine
]

{ #category : 'blocks - inline' }
MicBeamerWriter >> visitFigure: aFigure [
	canvas environment
		name: 'center';
		with: [ self includeGraphicsFor: aFigure ]
]

{ #category : 'visiting - extensions' }
MicBeamerWriter >> visitSlide: aSlide [
	canvas newLine.
	canvas environment
		name: 'frame';
		optParameter: 'fragile';
		with: [ 
					canvas newLine.
					self createFrametitle: aSlide title.
					canvas newLine.
					super visitSlide: aSlide ].
	canvas newLine
]
